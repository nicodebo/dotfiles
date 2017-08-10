# Pam

The `PAM_ENV` module of Pam allow to set/unset environment variable. The
advantage over setting environment variables from shell startup files is that
it is loaded before the shell and thus, is shell agnostic.

## Files

`~/.pam_environment`: File from where the `PAM_ENV` module load environment
variable.

## References

* <http://man7.org/linux/man-pages/man8/pam_env.8.html>
* <https://wiki.archlinux.org/index.php/Environment_variables#Using_pam_env>
