1. tablespaces, filespaces
   A space may consist of multiple actual files at the operating system level (e.g. ibdata1, ibdata2, etc.) but it is just a single logical file — multiple physical files are just treated as though they were physically concatenated together

   Each space in InnoDB is assigned a 32-bit integer space ID.

   Through MySQL, InnoDB currently only supports additional spaces in the form of “file per table” spaces,
   which create an .ibd file for each MySQL table. Internally, this .ibd file is actually a fully functional
   space which could contain multiple tables, but in the implementation with MySQL, they will only contain a single table.

2. Pages
   Each space is divided into pages, normally 16 KiB each

   Each page within a space is assigned a 32-bit integer page number, often called “offset”, which is actually just the page’s offset from the beginning of the space

   InnoDB has a limit of 64TiB of data; this is actually a limit per space, and is due primarily to the page number being a 32-bit integer combined with the default page size: 232 x 16 KiB = 64 TiB

3. xdes pages.
   manage 64 pages.
   1 extent = 64 pages = 64 * 16 * 1024 = 1Mib.

   what is xdes entry? why has 256 xdes entries?

   xdes pages:
   InnoDB allocates FSP_HDR and XDES pages at fixed locations within the space, to keep track of which extents are in use, and which pages within each extent are in use.

   1 xdes page = 256 extents = 256.

   extent descriptor lists = xdes entry lists.

   extent list.

4. what is file segment?
   an INODE entry in InnoDB merely describes a file segment (frequently called an FSEG), and will be referred to as a “file segment INODE” from now on.

   file segment contains extents.

   file segment -> file.
   inode -> file inode.

   as each index consumes exactly two file segment INODE entries.

   file segment header purpose?
    - The file segment header points to the inode describing the file segment.

   Although INDEX pages haven’t been described yet, one small aspect can be looked at now.
   The root page of each index’s FSEG header contains pointers to the file segment INODE entries
   which describe the file segments used by the index. Each index uses one file segment for leaf
   pages and one for non-leaf (internal) pages. This information is stored in the FSEG header structure
