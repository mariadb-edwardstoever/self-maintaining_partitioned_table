# Self-maintaining Partitioned Table 

A procedure called by a scheduled event that reorganizes the partition automatically every hour. As an alternative to using an event object, it is just as easy to use crontab.

In this example, the table is maintained with 24 one hour partitions ahead of now. Partitions older than 48 hours are dropped.

This example can be modified to self-maintain tables partitioned by day, month or year.

REF: support ticket CS0644056
