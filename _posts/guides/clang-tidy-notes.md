# Clang-tidy notes

[clang-tidy 15 documentation](https://releases.llvm.org/15.0.0/tools/clang/tools/extra/docs/clang-tidy/index.html)
[minimal .clang-tidy](https://github.com/cpp-best-practices/gui_starter_template/blob/main/.clang-tidy)
[Intro to Clang-tidy](https://www.youtube.com/watch?v=OchPaGEH4TE)
[clang-tidy checks to avoid](https://www.youtube.com/watch?v=oxpsHk1yq88)

The '.*' header regex argument should ignore system headers.

Multiple C++ files don't handle fixes well, either perform fixes manually or do
them one file at a time.
