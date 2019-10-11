Class {
	#name : #SCommand,
	#superclass : #Object,
	#instVars : [
		'result',
		'name',
		'time',
		'function'
	],
	#category : #'Suchai-LogParser'
}

{ #category : #accessing }
SCommand >> function [
	^ function
]

{ #category : #accessing }
SCommand >> function: anObject [
	function := anObject
]

{ #category : #accessing }
SCommand >> name [
	^ name
]

{ #category : #accessing }
SCommand >> name: anObject [
	name := anObject
]

{ #category : #printing }
SCommand >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	str nextPutAll: self time asString.
	str nextPut: $,.
	str nextPutAll: self name.
	str nextPut: $>.
]

{ #category : #accessing }
SCommand >> result [
	^ result
]

{ #category : #accessing }
SCommand >> result: anObject [
	result := anObject
]

{ #category : #accessing }
SCommand >> time [
	^ time
]

{ #category : #accessing }
SCommand >> time: anObject [
	time := anObject
]
