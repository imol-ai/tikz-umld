#!/bin/sh
# Re-indent the LaTeX sources with latexindent, using .latexindent.yaml, which
# only changes whitespace at the start and end of lines.
#
#   tools/latexindent.sh format [FILE...]   rewrite files in place
#   tools/latexindent.sh check  [FILE...]   fail, showing a diff, if a file would change
#
# Without FILE arguments, every .sty, .tex and .lvt file in the repository is used.
#
# The output differs between latexindent versions, so locally and in CI the
# same version must be used: the one in TeX Live 2025.  Set LATEXINDENT to
# another command (for example "perl /path/to/latexindent.pl") to override the
# program, and LATEXINDENT_ANY_VERSION=1 to skip the version check.
set -eu
cd "$(dirname "$0")/.."

expected_version=3.24.7
latexindent=${LATEXINDENT:-latexindent}

mode=${1:?usage: $0 format|check [FILE...]}
shift
case $mode in format | check) ;; *) echo "usage: $0 format|check [FILE...]" >&2; exit 2 ;; esac

if [ -z "${LATEXINDENT_ANY_VERSION:-}" ]; then
	# shellcheck disable=SC2086 # LATEXINDENT may be a command with arguments
	version=$($latexindent --version 2>/dev/null | grep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*' | head -n 1)
	if [ "$version" != "$expected_version" ]; then
		echo "latexindent ${version:-?} found, but $expected_version is required (its output differs between versions)." >&2
		echo "Set LATEXINDENT_ANY_VERSION=1 to use it anyway." >&2
		exit 2
	fi
fi

if [ $# -gt 0 ]; then
	files=$*
else
	files=$(find . \( -path ./.git -o -path ./build \) -prune -o -type f \
		\( -name '*.sty' -o -name '*.tex' -o -name '*.lvt' \) -print | sort)
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
status=0
for f in $files; do
	# shellcheck disable=SC2086
	if ! $latexindent -l .latexindent.yaml -c "$tmp/" "$f" >"$tmp/out" 2>"$tmp/err"; then
		cat "$tmp/err" >&2
		echo "latexindent failed on $f" >&2
		exit 2
	fi
	if ! cmp -s "$f" "$tmp/out"; then
		if [ "$mode" = format ]; then
			cat "$tmp/out" >"$f" # keeps the file's permissions
			echo "formatted $f"
		else
			echo "needs formatting: $f" >&2
			diff -u "$f" "$tmp/out" | head -20 >&2 || true
			status=1
		fi
	fi
done
exit $status
