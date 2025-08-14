---
title:      PegasusTools                 # Title
author:     Robert Caddy               # Author Name
date:       2025-08-14 09:00:00 -0400  # Date
categories: []     # Catagories, no more than 2
tags:       [Pegasus++, PIC, Analysis Package, Python, RSE]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

# PegasusTools: An Analysis Package for Pegasus

The goal of this project was to convert some of the miscellaneous Python and Matlab scripts that users of the Pegasus PIC code have into a pip installable Python package, named [PegasusTools](https://github.com/PegasusPIC/pegasustools). At the conclusion of the project PegasusTools has utilities for reading the binary and ASCII files that Pegasus outputs along with some tools to standardize plotting. All of the existing scripts provided to me can be found [here](https://github.com/PegasusPIC/pegasustools/tree/main/old_scripts).

Usage details can be found in the [documentation](https://pegasustools.readthedocs.io/en/stable/) (also linked on GitHub). Details on how to add new things can be found in [CONTRIBUTING.md](https://github.com/PegasusPIC/pegasustools/blob/main/.github/CONTRIBUTING.md).

## Repo/Project Structure

The project repository is based on the [Cookie](https://github.com/scientific-python/cookie) template for scientific Python packages. The template came with all the infrastructure for CI/CD, pre-commit, packaging, uploading to PyPI, etc. I made minor modifications but nothing that significantly impacts usage. All current content is well tested with ~96% test coverage.

## Features

All the features here are detailed in the documentation, this is just a high level summary.

### Reading NBF Files

NBF binary files from Pegasus can be read the public `PegasusNBFData` class. This method is 15-22x faster than the previous methods used to load NBF files by the group.

Performance tests were performed on a 431MB NBF file. Note that the Della results can vary significantly depending on network congestion. To account for this I ran the test with `timeit` several times over about an hour and picked the results that showed reasonably low standard deviations.

|          | Della   | MacBook (M3 Max, 2TB SSD) |
|----------|---------|---------------------------|
| Previous | 61MB/s  | 127MB/s                   |
| New      | 910MB/s | 2.8GB/s                   |
| Speedup  | 15x     | 22x                       |

### Reading Spectra Files

The various spectra files from Pegasus can be read with the `PegasusSpectralData` class. This method is 41-152x faster than the previous one. Testing was done on a 3.44GB `.spec` file with a similar testing strategy on Della as was discussed in the [Reading NBF Files](#reading-nbf-files) section.

|          | Della   | MacBook (M3 Max, 2TB SSD) |
|----------|---------|---------------------------|
| Previous | 28MB/s  | 52MB/s                    |
| New      | 1.14GB/s | 7.9GB/s                   |
| Speedup  | 41x   | 152x                      |

### Reading Track Files

Reading particle track files is more complex than the other file types and is where I spent the largest portion of time in this project. There are two formats, ASCII `.track.dat` files and binary `.track_mpiio_optimized` files. The ASCII files are one particle per file but there are typically tens of thousands of files totalling up to a few hundred gigabytes. Each binary file has the data from all particles in a given time range but that data is ordered based on MPI rank not particle ID and as such the particle IDs are nearly randomly ordered both within one file and across the entire dataset. Total data size for the binary track files is up to about 2TB. This data then needs to be searched through to find interesting particle tracks. I decided that instead of reading these files directly when searching that first I would convert them into Parquet files, which are optimized for this kind of data and searches.

Due to the large data sizes I would need to use some kind of framework that supported performant larger-than-memory operations. The three I found that might meet my needs were PySpark, Dask DataFrame, and Polars. PySpark requires considerable setup that isn't feasible in all cases. I spent quite a bit of time trying to get Dask Dataframes to work properly but kept running into issues. Either it would run out of memory, hang, or take an absurdly long time to finish. Given these issues I ended up using [Polars](https://pola.rs), a parallel dataframe library for Python and Rust. The streaming engine (for larger than memory operations) in Polars is currently undergoing a rewrite and is missing a few features, namely `.sort` doesn't work in streaming mode at the moment. As such I did much of the parallelization manually to avoid having to sort the entire dataset at once.

Converting a large set of ASCII track files only takes a few minutes. Converting a 2TB binary dataset takes about 2 hours on Stellar using 16 cores and 256GB of memory. This is a one-time cost that also computes several useful quantities along the way for easier future searching. I don't have hard numbers for how much faster this is but my estimate is that it reduces a single search from hours to minutes.

### Reading History Files

`.hst` files can be loaded with the `load_hst_file` function which returns a Polars DataFrame. The loading function accounts for any restarts and only uses data from the latest run. This files are small so I didn't do any performance testing, load times are usually a fraction of a second.

### Plotting

PegasusTools includes a matplotlib style sheet `pegasus_style` that can be used to set the style of matplotlib. PegasusTools also defines a new colormap, the Hawley colormap shown below. PegasusTools registers the Hawley colormap with matplotlib when PegasusTools is imported so the `hawley` colormap can be used just like any built-in colormap. Also, the Hawley colormap is the default colormap in the `pegasus_style` style sheet.

<div style="vertical-align: middle;"><strong>hawley</strong> </div><div class="cmap"><img alt="hawley colormap" title="hawley" style="border: 1px solid #555;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgAAAABACAYAAABsv8+/AAAAFXRFWHRUaXRsZQBoYXdsZXkgY29sb3JtYXCeBOYcAAAAG3RFWHREZXNjcmlwdGlvbgBoYXdsZXkgY29sb3JtYXDXk/74AAAAMXRFWHRBdXRob3IATWF0cGxvdGxpYiB2My4xMC41LCBodHRwczovL21hdHBsb3RsaWIub3Jn7aEU8wAAADN0RVh0U29mdHdhcmUATWF0cGxvdGxpYiB2My4xMC41LCBodHRwczovL21hdHBsb3RsaWIub3JnSIUHBwAAAX9JREFUeJzt1sFOAkEUBdGHE/1tv1sN6ILBRCLRBQzGOmdzA9OhCRtqN/P8PjMzs8ymu/vn9y0Px32abfZxo3vudd+6y35vr7mz7mKvufM6X/fl7PXbD8/Pz116fuu99/3rHg7HXX/dzz3M9+9f2t+ev9Xn/pXvcTq3/ksBACUCAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAECQAACAIAEAAEECAACCBAAABAkAAAgSAAAQJAAAIEgAAEDQB/pZ1waNyltwAAAAAElFTkSuQmCC"></div><div style="vertical-align: middle; max-width: 514px; display: flex; justify-content: space-between;"><div style="float: left;"><div title="#00007fff" style="display: inline-block; width: 1em; height: 1em; margin: 0; vertical-align: middle; border: 1px solid #555; background-color: #00007fff;"></div> under</div><div style="margin: 0 auto; display: inline-block;">bad <div title="#00000000" style="display: inline-block; width: 1em; height: 1em; margin: 0; vertical-align: middle; border: 1px solid #555; background-color: #00000000;"></div></div><div style="float: right;">over <div title="#870000ff" style="display: inline-block; width: 1em; height: 1em; margin: 0; vertical-align: middle; border: 1px solid #555; background-color: #870000ff;"></div></div></div>
