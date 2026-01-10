/*
 * Storage media: some hard drive, SSD, etc, that maintains a large sequence of bytes
 * File system organizes files on a device
 *
 * In UNIX, everything is a file
 *
 * The root directory "/" is the starting point (parent of all sub-directories)
 *
 * A directory is a file that contains mapping of filenames to their data and metadata
 *
 * In teach.cs, everyone's files are in the same filesystem (shared system)
 * 
 * Every file has an owner and group
 * Permissions are specified separately for the owner, group, and everything else
 *
 * File permissions
 * -rwxrwxrwx
 * - is for regular files, d is for directories
 *
 * Users can belong to many groups, yet files can only belong to 1 group
 * chmod changes the permission of a file that you own
 *
 * cd /u/csc209h/winter/pub/demo
 *
 * Privacy harms
 *   Physical
 *   Economic
 *   Reputational
 *   Discrimination
 *   Relationship
 *   Psychological
 *
 * From Lab:
 * Program: sequence of instructions to a computer
 * Compiler: converts C code into very basic machine-level instructions
 * I/O: information sent to/received from users and external devices
 *
 * C variable names:
 * - can only contain alpha numeric characters and underscores
 * - cannot begin with a number
 * - are case sensitive
/
