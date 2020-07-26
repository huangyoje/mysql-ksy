# Page Management

# TableSpace
- For a file-per-table tablespace the tablespace name is the same as that of the file/table name.
- Tablespaces are identified with a unique ID which is called tablesapce ID.

# Pages
- Tablespace file is made of number of fixed size pages.
- There are different type of pages to serve different purpose.

# Extents
- An extent is a collection of contiguous pages within tablespace.
- Extent size is 1 MB. Thus if page size is 16Kb then there could be 64 pages in an Extent.

An extent is the basic unit of file space allocation in InnoDB.

# Header Page
Meta-data information of tablespace is stored in the same file in header page (always page 0).

# Extent Descriptor Page(XDES Page)
An extent is a collection of pages. We need to store some metadata information related to pages which belongs to an Extent. To store this information, we have ‘extent descriptor page’.

## XDES Entry

how many XDES Entries in a XDES Page?

As the  tablespaces grows (i.e. more data is added), more extents (more pages) will be allocated. Once the number of total extents is greater than what an XDES page can track a new XDES page is allocated which will be used to track the next set of extents.

## Some Mathematics!

One extent size   = 1 MB
One page size       = 16 KB
Total pages in one extent = 64 Pages
Total XDES entries in one XDES page = 256
Total Extents could be covered in one XDES page = 256
Total pages could be covered with one XDES Page = 16384

For ease of implementation: number of pages covered by one XDES page entries is equal to page size.

So once tablespace size exceeds 16384 pages, we need to allocate a new XDES page to keep metadata of further extents (to be allocated).


# Inode Page
These are the pages which keep information about File Segments (FSEG). So before going into INDOE pages entry let’s understand File Segments.


## File Segment
A File Segment is a logical unit which is a collection of Pages and Extents.

As a table grows it will allocate individual pages in each file segment until the fragment array becomes full, and then switch to allocating 1 extent at a time, and eventually to allocating 4 extents at a time.




References
===========

[1](https://mysqlserverteam.com/innodb-tablespace-space-management/)
[2](https://mysqlserverteam.com/extent-descriptor-page-of-innodb/)
