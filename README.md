# Codeminer Quake Log Parser
Project made in Ruby for Codeminer interview

# Setup
Install Ruby 2.3 from the [official documentation](https://www.ruby-lang.org/en/documentation/installation/)

## Running
### Tasks
run the files `task1.rb`, `task2.rb` and `task_plus.rb` with the command `ruby file_name_here.rb`. 
> If there's make support on your OS you may use `make task.1` or `make task.2` or `make task.plus`.
### Tests
run the file `test_runner.rb` with the command `ruby test_runner.rb`.
> If there's make support on your OS you may use `make test`.

# Documentation
This project has the following entities & files:
- [Player](#player)
- [Kill](#kill)
- [Game](#game)
- [LogParser](#logparser)
- [task1.rb](#task1rb)
- [task2.rb](#task2rb)
- [task_plus.rb](#task_plusrb)

# Player
>Class Diagram
![player diagram](https://github.com/rodrigondec/codeminer/blob/master/imgs/player.png?raw=true "Player Diagram")

## Attributes
### name
String containing the player name
### kills
Number containing the count of player kills 

## Methods
### increment_kill
Increments the attribute `kills` counter by `1`

### decrement_kill
Decrements the attribute `kills` counter by `1`

### add_kills
receive the parameters: 
- number

Increments the attribute `kills` counter by a provided `number`

# Kill
>Class Diagram
![kill diagram](https://github.com/rodrigondec/codeminer/blob/master/imgs/kill.png?raw=true "Kill Diagram")

## Attributes
### killer
Player instance of class [`Player`](#player) who made the kill. Value can be `nil` in case of `<world>` kill
### victim
Player instance of class [`Player`](#player) who has been killed
### mean
String containing death cause name

# Game
>Class Diagram
![game diagram](https://github.com/rodrigondec/codeminer/blob/master/imgs/game.png?raw=true "Game Diagram")

## Attributes
### name
String containing game name
### players
Hash of players on the game. The key of the hash is the name of player and the value is a `Player` instance.
>image example
![hash players example](https://github.com/rodrigondec/codeminer/blob/master/imgs/players_hash.png?raw=true "Hash Players Example")
### kills
List of kills (instance of class [`Kill`](#kill)) on the game

## Methods
### info
Return a hash containing `total_kills`, `players` and `kills`
>image example
![game info example](https://github.com/rodrigondec/codeminer/blob/master/imgs/game_info.png?raw=true "Game Info Example")

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

Call method [`add_player`](#add_player) if there's no such player or return the player instance

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
>line example `20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT`

# LogParser
>Class Diagram
![parser diagram](https://github.com/rodrigondec/codeminer/blob/master/imgs/parser.png?raw=true "Parser Diagram")

## Attributes
### data
List of strings extracted from the games.log file
### games
List of [`Game`](#game) instances

## Methods
### info
Puts the game.[`info`](#info) from each game from [`games`](#games)

### parse
- Creates the [`Game`](#game) instances
- Identify [`kill_lines`](#process_kill_line) & [`user_info_lines`](#process_user_info_line)

# Task1.rb
Script for task 1
```ruby
require './parser'
require 'pp'

parser = LogParser.new('games.log')
pp parser.get_game_info(0)
```

# Task2.rb
Script for task 2
```ruby
require './parser'
require 'pp'

parser = LogParser.new('games.log')

# Getting all players from all games
# The kills from player from each game has to be summed
global_players_hash = {}
parser.games.each do |game|
	game.players.each_value do |player|
		if global_players_hash.key?(player.name)
			global_players_hash[player.name].add_kills(player.kills)
		else
			global_players_hash[player.name] = player
		end
	end
end

# Parsing hash to list of hashs
global_players_list = []
global_players_hash.each_value do |player|
	global_players_list.push(name: player.name, kills: player.kills)
end

# Ordering list for global ranking
global_ranking = global_players_list.sort_by { |info| -info[:kills] }

pp parser.all_games_info

# Printing global ranking
h = {}
h['ranking geral'] = global_ranking
pp h
```

# Task_plus.rb
Script for task plus
```ruby
require './parser'
require 'pp'

parser = LogParser.new('games.log')

parser.games.each do |game|

	# Creating hash counter entry for each mean of kill from the game
	kills_by_means = {}
	game.kills.each do |kill|
		if kills_by_means.key?(kill.mean)
			kills_by_means[kill.mean] += 1
		else
			kills_by_means[kill.mean] = 1
		end
	end
	
	# Ordering the hash for ranking like output
	kills_by_means = kills_by_means.sort_by { |mean, count| -count }
	kills_by_means.to_h
	h = {}
	h[game.name] = { 'kills_by_means': kills_by_means }
	pp h
end
```
