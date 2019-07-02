# Codeminer Quake Log Parser
Project made in Ruby for Codeminer interview

## Setup
Install Ruby 2.3.3p222 from the [official documentation](https://www.ruby-lang.org/en/documentation/installation/#package-management-systems)

### Running
run the files `task1.rb`, `task2.rb` and `task_plus.rb` with the command `ruby file_name_here.rb`. 
> If there's make support on your OS you may use `make task.1` or `make task.2` or `make task.plus`.

# Documentation
This project has the following entities:
- [Player](#player)
- [Kill](#kill)
- [Game](#game)
- [LogParser](#logparser)

## Player
Class representing a player. Contains the name and kill counter of the player

### Attributes
#### name
string containing the player name
#### kills
number containing the count of player kills 

### Methods
#### name
##### description
attr_reader for the attribute with same name

#### kills
##### description
attr_reader for the attribute with same name

#### increment_kill
##### description
increments the attribute `kills` counter by `1`

#### decrement_kill
##### description
decrements the attribute `kills` counter by `1`

#### add_kills
##### parameters
- number
##### description
increments the attribute `kills` counter by a provided `number`

## Kill
Class representing a kill. Contains the killer, victim and the mean

### Attributes
#### killer
player instance of class [`Player`](#player) who made the kill. Value can be `nil` in case of `<world>` kill
#### victim
player instance of class [`Player`](#player) who has been killed
#### mean
string containing death cause name

### Methods
#### mean
##### description
attr_reader for the attribute with same name

## Game
Class representing a game. Contains the name of the game, hash of players and list of kills

### Attributes
#### name
string containing game name
#### players
hash of players on the game. The key of the hash is the name of player and the value is a `Player` instance.
##### example
![hash players example](docs/players_hash.png?raw=true "Hash Players Example")
#### kills
list of kills (instance of class [`Kill`](#kill)) on the game

### Methods
#### players
##### description
attr_reader for the attribute with same name

#### kills
##### description
attr_reader for the attribute with same name

#### info
##### description
return a hash containing `total_kills`, `players` and `kills`
##### example
![game info example](docs/game_info.png?raw=true "Game Info Example")

#### players_info 
##### description
return a list containing the name of each player on the game. Used on [`info`](#info) method

#### kills_info
##### description
return a list of hashs containing the pair `:name => String, :kills=> Number` from the players. Used on [`info`](#info) method 
#### ranking
##### description
return the [`kills_info`](#kills_info) list sorted by `-:kills`

#### add_player
##### parameters
- name: String
##### description
create a new [`Player`](#player) instance and save it on [`players`](#players) attribute

#### add_kill
##### parameters
- killer: [`Player`](#player) instance or `nil`
- victim: [`Player`](#player) instance
- mean: String
##### description
create a new [`Kill`](#kill) instance and save it on [`kills`](#kills) attribute

#### create_or_get_player
##### parameters
- name: String
##### description
call method [`add_player`](#add_player) if there's no sush player or return the player instance

#### get_player
##### parameters
- name: String
##### description
return nill if `name == '<world>'` or call method [`create_or_get_player`](#create_or_get_player)

#### process_kill
##### parameters
- killer_name: String
- victim_name: String
- mean: String
##### description
1. create or get killer & victim [`Player`](#player) instances
2. increment or decrement the players [`kills counter`](#kills)
3. call method [`add_kill`](#add_kill)

#### process_user_info_line
##### parameters
- user_info_line: String
##### description
create a [`Player`](#player) instance getting the name from line
##### example
`20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0`

#### process_kill_line
##### parameters
- kill_line: String
##### description
- identify `killer_name`, `victim_name` & `mean`
- call method [`process_kill`](#process_kill)
##### example
`20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT`

## LogParser
Class for parsing the games.log

### Attributes
#### data
list of strings extracted from the games.log file
#### games
list of [`Game`](#game) instances

### Methods
#### games
##### description
attr_reader for the attribute with same name

#### info
##### description
puts the game.[`info`](#info) from each game from [`games`](#games)

#### parse
##### description
- creates the [`Game`](#game) instances
- identify [`kill_lines`](#process_kill_line) & [`user_info_lines`](#process_user_info_line)

