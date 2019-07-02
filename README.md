# Codeminer Quake Log Parser
Project made in Ruby for Codeminer interview

# Setup
Install Ruby 2.3.3p222 from the [official documentation](https://www.ruby-lang.org/en/documentation/installation/#package-management-systems)

## Running
run the files `task1.rb`, `task2.rb` and `task_plus.rb` with the command `ruby file_name_here.rb`. 
> If there's make support on your OS you may use `make task.1` or `make task.2` or `make task.plus`.

# Documentation
This project has the following entities & files:
- [Player](#player)
- [Kill](#kill)
- [Game](#game)
- [LogParser](#logparser)
- [task1.rb](#task1.rb)
- [task2.rb](#task2.rb)
- [task_plus.rb](#task_plus.rb)

## Player
Class representing a player. Contains the name and kill counter of the player

### Attributes
#### name
String containing the player name
#### kills
Number containing the count of player kills 

### Methods
#### name
##### Description
Attr_reader for the attribute with same name

#### kills
##### Description
Attr_reader for the attribute with same name

#### increment_kill
##### Description
Increments the attribute `kills` counter by `1`

#### decrement_kill
##### Description
Decrements the attribute `kills` counter by `1`

#### add_kills
##### Parameters
- number
##### Description
Increments the attribute `kills` counter by a provided `number`

## Kill
Class representing a kill. Contains the killer, victim and the mean

### Attributes
#### killer
Player instance of class [`Player`](#player) who made the kill. Value can be `nil` in case of `<world>` kill
#### victim
Player instance of class [`Player`](#player) who has been killed
#### mean
String containing death cause name

### Methods
#### mean
##### Description
Attr_reader for the attribute with same name

## Game
Class representing a game. Contains the name of the game, hash of players and list of kills

### Attributes
#### name
String containing game name
#### players
Hash of players on the game. The key of the hash is the name of player and the value is a `Player` instance.
##### Example
![hash players example](docs/players_hash.png?raw=true "Hash Players Example")
#### kills
List of kills (instance of class [`Kill`](#kill)) on the game

### Methods
#### players
##### Description
Attr_reader for the attribute with same name

#### kills
##### Description
Attr_reader for the attribute with same name

#### info
##### Description
Return a hash containing `total_kills`, `players` and `kills`
##### Example
![game info example](docs/game_info.png?raw=true "Game Info Example")

#### players_info 
##### Description
Return a list containing the name of each player on the game. Used on [`info`](#info) method

#### kills_info
##### Description
Return a list of hashs containing the pair `:name => String, :kills=> Number` from the players. Used on [`info`](#info) method 
#### ranking
##### Description
Return the [`kills_info`](#kills_info) list sorted by `-:kills`

#### add_player
##### Darameters
- name: String
##### Description
Create a new [`Player`](#player) instance and save it on [`players`](#players) attribute

#### add_kill
##### Parameters
- killer: [`Player`](#player) instance or `nil`
- victim: [`Player`](#player) instance
- mean: String
##### Description
Create a new [`Kill`](#kill) instance and save it on [`kills`](#kills) attribute

#### create_or_get_player
##### Parameters
- name: String
##### Description
Call method [`add_player`](#add_player) if there's no sush player or return the player instance

#### get_player
##### Parameters
- name: String
##### Description
Return nill if `name == '<world>'` or call method [`create_or_get_player`](#create_or_get_player)

#### process_kill
##### Parameters
- killer_name: String
- victim_name: String
- mean: String
##### Description
1. Create or get killer & victim [`Player`](#player) instances
2. Increment or decrement the players [`kills counter`](#kills)
3. Call method [`add_kill`](#add_kill)

#### process_user_info_line
##### Parameters
- user_info_line: String
##### Description
Create a [`Player`](#player) instance getting the name from line
##### Example
`20:34 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0`

#### process_kill_line
##### Parameters
- kill_line: String
##### Description
- Identify `killer_name`, `victim_name` & `mean`
- Call method [`process_kill`](#process_kill)
##### Example
`20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT`

## LogParser
Class for parsing the games.log

### Attributes
#### data
List of strings extracted from the games.log file
#### games
List of [`Game`](#game) instances

### Methods
#### games
##### Description
Attr_reader for the attribute with same name

#### info
##### Description
Puts the game.[`info`](#info) from each game from [`games`](#games)

#### parse
##### Description
- Creates the [`Game`](#game) instances
- Identify [`kill_lines`](#process_kill_line) & [`user_info_lines`](#process_user_info_line)

