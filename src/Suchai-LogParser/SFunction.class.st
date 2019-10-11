Class {
	#name : #SFunction,
	#superclass : #Object,
	#instVars : [
		'name',
		'commands'
	],
	#category : #'Suchai-LogParser'
}

{ #category : #initialization }
SFunction >> addCommand: aCommand [
	commands add: aCommand 
]

{ #category : #'as yet unclassified' }
SFunction >> alwaysSucceed [
	^ commands allSatisfy: [ :c | c result = 1 ]
]

{ #category : #accessing }
SFunction >> commands [
	^ commands
]

{ #category : #initialization }
SFunction >> initialize [
	super initialize.
	commands := OrderedCollection new.
]

{ #category : #accessing }
SFunction >> name [
	^ name
]

{ #category : #accessing }
SFunction >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
SFunction >> numberOfExecutions [
	^ commands size
]

{ #category : #printing }
SFunction >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	str nextPutAll: self name.
	str nextPut: $>.
]

{ #category : #'as yet unclassified' }
SFunction >> results [
	^ (commands collect: #result) asSet
]
