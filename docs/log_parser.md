# LogParser
Class for parsing the games.log

## Attributes
### data
List of strings extracted from the games.log file
### games
List of [`Game`](#game) instances

## Methods
### games
Attr_reader for the attribute with same name

### info
Puts the game.[`info`](#info) from each game from [`games`](#games)

### parse
- Creates the [`Game`](#game) instances
- Identify [`kill_lines`](#process_kill_line) & [`user_info_lines`](#process_user_info_line)
