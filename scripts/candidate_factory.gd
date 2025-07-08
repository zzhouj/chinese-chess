class_name CandidateFactory
extends RefCounted

const CANDIDATE = preload("res://scenes/candidate.tscn")

static func build(coordinate: Vector2i) -> Candidate:
	var candidate: Candidate = CANDIDATE.instantiate()
	candidate.coordinate = coordinate
	return candidate
