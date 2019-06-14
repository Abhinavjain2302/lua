local hscores_key = KEYS[1]
local user = ARGV[1]
local increment = ARGV[2]
local new_score = redis.call('HINCRBY', hscores_key, user, increment)

local old_score = new_score - increment
local hcounts_key = KEYS[2]
local old_count = redis.call('HINCRBY', hcounts_key, old_score, -1)
local new_count = redis.call('HINCRBY', hcounts_key, new_score, 1)


local zdranks_key = KEYS[3]
if new_count == 1 then
  redis.call('ZADD', zdranks_key, new_score, new_score)
end
if old_count == 0 then
  redis.call('ZREM', zdranks_key, old_score)
end