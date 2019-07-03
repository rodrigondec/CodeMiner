# Kill
Class representing a kill. Contains the killer, victim and the mean

## Attributes
### killer
Player instance of class [`Player`](#player) who made the kill. Value can be `nil` in case of `<world>` kill
### victim
Player instance of class [`Player`](#player) who has been killed
### mean
String containing death cause name

## Methods
### mean
Attr_reader for the attribute with same name