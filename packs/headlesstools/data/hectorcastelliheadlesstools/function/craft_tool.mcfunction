# Spawn a temporary item, which will later be changed into the final tool
summon item ~ ~ ~ {Tags:["temp_item"], Item:{id:"minecraft:stone", count:1}}
# Set the ID from the entity passed to this function
data modify entity @e[tag=temp_item, limit=1] Item.id set from entity @s Item.id
# Transfer enchantments from blade
data modify entity @e[tag=temp_item, limit=1] Item.components."minecraft:enchantments" set from entity @s Item.components."minecraft:enchantments"
# Remove the leftover tag
tag @e[tag=temp_item] remove temp_item
# Remove a nearby stick
kill @e[type=item, distance=..0.5, limit=1, nbt={OnGround:true,Item:{id:"minecraft:stick", components:{"minecraft:custom_data":{headlesstools:true,type:"handle"}}}}]
# Remove the leftover blade
kill @s