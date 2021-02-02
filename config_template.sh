#Template file for ./config.sh, which is necessary for most scripts

#this declares `name` as an associative array
typeset -A name

#enter the names of the correctors here.
#The string used as the key will also be used as a dirname, so be aware of that.
#The name will be added as a signature at the bottom of feedback (see ./name.sh)
name[alex]="Alex Doe"

#specify files of _which_ extension in nicelistdir should be considered
#this is to exclude e.g. binary, IDE files.
niceListFileExts="hs java cpp"

# All nicelisted files should be in this directory, e.g. one level up of the current working directory.
# It should not be in the CWD to not be confused with a student submission.
# TODO: It is okay if this directory does not exist, the nicelist feature is then not used.
NICELISTDIR="../plagiarism-nicelist"
