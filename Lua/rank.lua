local hscores_key = KEYS[1]
local zdranks_key = KEYS[2]
local user = ARGV[1]

local score = redis.call('HGET', hscores_key, user)
return redis.call('ZRANK', zdranks_key, score)