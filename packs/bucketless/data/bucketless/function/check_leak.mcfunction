# Apply damage to all filled buckets with our leak tag
execute as @a[predicate=bucketless:has_leaks] run function bucketless:leak_scan
# Reset the tick timer
scoreboard players set @s bucketless_timer 0
