# Tick the main scoreboard
execute as @a run scoreboard players add @s bucketless_timer 1
# If we reached the threshold then we process the inventory for damage and reset the scoreboard
execute as @a[scores={bucketless_timer=20..}] run function bucketless:check_leak