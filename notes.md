LRU cache

1. get
update LRU records with the fact that key A was read
return the value

2. set
check if we have N keys already, where N is LRU size
if yes, evict key that we haven't read

write the value
