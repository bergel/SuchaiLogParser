Class {
	#name : #SModel,
	#superclass : #Object,
	#instVars : [
		'commands',
		'functions'
	],
	#category : #'Suchai-LogParser'
}

{ #category : #parsing }
SModel >> buildFunctions [
	| functionNames |
	functionNames := (commands collect: #name) asSet.
	functions := functionNames collect: [ :fName | SFunction new name: fName ].
	commands do: [ :c |
		| fetchedFunction |
		fetchedFunction := functions detect: [ :f | f name = c name ].
		fetchedFunction addCommand: c.
		c function: fetchedFunction.
	].
	
]

{ #category : #accessing }
SModel >> commands [
	^ commands 
]

{ #category : #accessing }
SModel >> functions [
	^ functions 
]

{ #category : #ui }
SModel >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Functions';
		initializeView: [ self visualizeFunctions ]
]

{ #category : #'as yet unclassified' }
SModel >> numberOfCommands [
	^ commands size
]

{ #category : #'as yet unclassified' }
SModel >> numberOfFunctions [
	^ functions size
]

{ #category : #parsing }
SModel >> parseFileName: aFilename [
	^ self parseString: aFilename asFileReference contents
]

{ #category : #parsing }
SModel >> parseString: aString [

	| relevantLines runningCommand |
	relevantLines := aString lines select: [ :aLine | (aLine beginsWith: '[INFO ]') and: [ '*[Executer]*' match: aLine ] ].
	relevantLines := relevantLines select: [ :aLine | ('*Running the command: *' match: aLine) or: [ '*Command result: *' match: aLine ] ].
	commands := OrderedCollection new.
	
	relevantLines do: [ :aLine |
		
		('*Running the command: *' match: aLine) ifTrue: [ 
			runningCommand := SCommand new.
			runningCommand time: (aLine substrings: '[]') second asInteger.
			runningCommand name: ((aLine substrings: '[]') fourth substrings: ':') second allButFirst allButLast allButLast allButLast.
			commands add: runningCommand.
			 ].
		('*Command result: *' match: aLine) ifTrue: [ 
			runningCommand result: (aLine substrings: ':') second asInteger.
			 ]
	].

	self buildFunctions
	
]

{ #category : #'as yet unclassified' }
SModel >> run01 [

	<script: 'self new run01'>
	
	| model |
	model := SModel new.
	model parseFileName: '/Users/alexandrebergel/Desktop/test_bus1_111019.txt'.
	model inspect.
]

{ #category : #ui }
SModel >> visualizeFunctions [
	| b |
	b := RTMondrian new.
	b shape circle 
		size: [ :f | f numberOfExecutions log * 40 ];
		color: Color gray;
		if: #alwaysSucceed color: [ Color green ];
		withTextAbove: #name.
	b nodes: self functions.
	b layout grid.
	^ b 
]
