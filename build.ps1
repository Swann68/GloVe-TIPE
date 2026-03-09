# Configuration
$CC = "gcc"
$CFLAGS = "-pthread -O3 -funroll-loops -Wall -Wextra -Wpedantic"
$LDLIBS = "-lm -pthread"
$BUILDDIR = "build"
$SRCDIR = "src"

# Créer le dossier build
New-Item -ItemType Directory -Force -Path $BUILDDIR | Out-Null

# Compiler les fichiers .o
& $CC -c "$SRCDIR/common.c"     -o "$BUILDDIR/common.o"     $CFLAGS.Split()
& $CC -c "$SRCDIR/vocab_count.c" -o "$BUILDDIR/vocab_count.o" $CFLAGS.Split()
& $CC -c "$SRCDIR/cooccur.c"    -o "$BUILDDIR/cooccur.o"    $CFLAGS.Split()
& $CC -c "$SRCDIR/shuffle.c"    -o "$BUILDDIR/shuffle.o"    $CFLAGS.Split()
& $CC -c "$SRCDIR/glove.c"      -o "$BUILDDIR/glove.o"      $CFLAGS.Split()

# Lier les exécutables
& $CC "$BUILDDIR/vocab_count.o" "$BUILDDIR/common.o" -o "$BUILDDIR/vocab_count.exe" $CFLAGS.Split() $LDLIBS.Split()
& $CC "$BUILDDIR/cooccur.o"     "$BUILDDIR/common.o" -o "$BUILDDIR/cooccur.exe"     $CFLAGS.Split() $LDLIBS.Split()
& $CC "$BUILDDIR/shuffle.o"     "$BUILDDIR/common.o" -o "$BUILDDIR/shuffle.exe"     $CFLAGS.Split() $LDLIBS.Split()
& $CC "$BUILDDIR/glove.o"       "$BUILDDIR/common.o" -o "$BUILDDIR/glove.exe"       $CFLAGS.Split() $LDLIBS.Split()

Write-Host "Build terminé !" -ForegroundColor Green