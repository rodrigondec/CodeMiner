# Game
Class representing a game. Contains the name of the game, hash of players and list of kills

## Attributes
### name
String containing game name
### players
Hash of players on the game. The key of the hash is the name of player and the value is a `Player` instance.
>image example
![hash players example](docs/imgs/players_hash.png?raw=true "Hash Players Example")
### kills
List of kills (instance of class [`Kill`](#kill)) on the game

## Methods
### players
Attr_reader for the attribute with same name

### kills
Attr_reader for the attribute with same name

### info
Return a hash containing `total_kills`, `players` and `kills`
>image example
![game info example](docs/imgs/game_info.png?raw=true "Game Info Example")

### players_info 
Return a list containing the name of each player on the game. Used on [`info`](#info) method

### kills_info
Return a list of hashs containing the pair `:name => String, :kills=> Number` from the players. Used on [`info`](#info) method 
### ranking
Return the [`kills_info`](#kills_info) list sorted by `-:kills`

### add_player
receive the parameters:
- name: String

Create a new [`Player`](#player) instance and save it on [`players`](#players) attribute

### add_kill
receive the parameters:
- killer: [`Player`](#player) instance or `nil`
- victim: [`Player`](#player) instance
- mean: String

Create a new [`Kill`](#kill) instance and save it on [`kills`](#kills) attribute

### create_or_get_player
receive the parameters:
- name: String

Call method [`add_player`](#add_player) if there's no sush player or return the player instance

### get_player
receive the parameters:
- name: String

Return `nil` if `name == '<world>'` or call method [`create_or_get_player`](#create_or_get_player)

### process_kill
receive the parameters:
- killer_name: String
- victim_name: String
- mean: String

Create or get killer & victim [`Player`](#player) instances.
Increment or decrement the players [`kills counter`](#kills).
Call method [`add_kill`](#add_kill).

### process_user_info_line
receive the parameters:
- user_info_line: String

Create a [`Player`](#player) instance getting the name from line
>line example `20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0`

### process_kill_line
receive the parameters:
- kill_line: String

Identify `killer_name`, `victim_name` & `mean`.
Call method [`process_kill`](#process_kill).
>line example`20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT`

