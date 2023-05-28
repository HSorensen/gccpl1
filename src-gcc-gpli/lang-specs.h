/* lang-specs.h */
/* https://gcc.gnu.org/onlinedocs/gcc/Spec-Files.html */
{".gpli",  "@gpli", 0, 1, 0},
{".pli",  "@gpli", 0, 1, 0},
{".pl1",  "@gpli", 0, 1, 0},
{".PLI",  "@gpli", 0, 1, 0},
{".PL1",  "@gpli", 0, 1, 0},
{"@gpli",  "gpli1 %i %(cc1_options) %{I*} %{!fsyntax-only:%(invoke_as)}", 0, 1, 0},