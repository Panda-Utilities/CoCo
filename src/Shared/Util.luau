--!strict
local String = require("./String")
local Fuzzy = require("./Fuzzy")
local CommandRunner = require("./CommandRunner")
local TypeUtils = require("./TypeUtils")
local Mutex = require("./Mutex")

local Util = {}

Util.splitStringSimple = String.splitStringSimple
Util.parseEscapeSequences = String.parseEscapeSequences
Util.encodeEscapedOperator = String.encodeEscapedOperator
Util.encodeEscapedOperators = String.encodeEscapedOperators
Util.splitString = String.splitString
Util.mashExcessArguments = String.mashExcessArguments
Util.trimString = String.trimString
Util.emulateTabstops = String.emulateTabstops

Util.makeFuzzyFinder = Fuzzy.makeFuzzyFinder
Util.getNames = Fuzzy.getNames
Util.makeEnumType = Fuzzy.makeEnumType

Util.runCommandString = CommandRunner.runCommandString
Util.runEmbeddedCommands = CommandRunner.runEmbeddedCommands
Util.substituteArgs = CommandRunner.substituteArgs
Util.makeAliasCommand = CommandRunner.makeAliasCommand

Util.makeDictionary = TypeUtils.makeDictionary
Util.makeListableType = TypeUtils.makeListableType
Util.splitPrioritizedDelimeter = TypeUtils.splitPrioritizedDelimeter
Util.parsePrefixedUnionType = TypeUtils.parsePrefixedUnionType
Util.makeSequenceType = TypeUtils.makeSequenceType

Util.mutex = Mutex.new

return Util
