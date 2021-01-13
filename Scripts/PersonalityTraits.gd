extends Node

enum Motivator {
	ACHIEVEMENT,
	ACQUISITION,
	ADORATION,
	PEACE,
	BENEFICENCE,
	CHAOS,
	COMPETITION,
	CONFLICT,
	CONQUEST,
	CORRUPTION,
	CREATION,
	DESTRUCTION,
	DISCOVERY,
	DOMESTICITY,
	EDUCATION,
	ENTERTAINMENT,
	ENSLAVEMENT,
	HEDONISM,
	HEROISM,
	HONOR,
	LIBERATION,
	LOVE,
	ORDER,
	PLAY,
	POWER,
	PROSELYTIZATION,
	PURITY,
	REBELLION,
	RECOGNITION,
	SERVICE,
	TORMENT,
	UNDERSTANDING,
	VICE
}

enum Disposition {
	JOYFUL,
	ANXIOUS,
	ANGRY,
	CONTEMPTUOUS,
	EXCITED,
	CURIOUS,
	APATHETIC,
	CALM,
	ASHAMED
}

enum Outlook {
	OPTIMISTIC,
	PESSIMISTIC
}

enum Integrity {
	CONSCIENTIOUS,
	UNSCRUPULOUS
}

enum Impulsiveness {
	CONTROLLED,
	SPONTANEOUS
}

enum Boldness {
	INTREPID,
	CAUTIOUS
}

enum Agreeableness {
	AGREEABLE,
	DISAGREEABLE
}

enum Interactivity {
	ENGAGING,
	RESERVED
}

enum Conformity {
	CONVENTIONAL,
	HETERODOX
}

var motivators = Motivator.keys()
var disposition = Disposition.keys()
var impulsiveness = Impulsiveness.keys()
var boldness = Boldness.keys()
var outlook = Outlook.keys()
var integrity = Integrity.keys()
var interactivity = Interactivity.keys()
var conformity = Conformity.keys()
var agreeableness = Agreeableness.keys()

func add_personality_traits_to(character):
	character.traits["motivator"] = motivators[randi()%(motivators.size()) - 1]
	character.traits["disposition"] = disposition[randi()%(disposition.size() - 1) - 1]
	character.traits["outlook"] = outlook[randi()%(outlook.size()) - 1]
	character.traits["impulsiveness"] = impulsiveness[randi()%(impulsiveness.size()) - 1]
	character.traits["boldness"] = boldness[randi()%(boldness.size()) - 1]
	character.traits["integrity"] = integrity[randi()%(integrity.size()) - 1]
	character.traits["interactivity"] = interactivity[randi()%(interactivity.size()) - 1]
	character.traits["conformity"] = conformity[randi()%(conformity.size()) - 1]
	character.traits["agreeableness"] = agreeableness[randi()%(agreeableness.size()) - 1]

