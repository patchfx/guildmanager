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
	OPTMISTIC,
	PESSIMISTIC
}

enum Integrity {
	Conscientious,
	Unscrupulous
}

enum Impulsiveness {
	Controlled,
	Spontaneous
}

enum Boldness {
	Intrepid,
	Cautious
}

enum Agreeableness {
	Agreeable,
	Disagreeable
}

enum Interactivity {
	Engaging,
	Reserved
}

enum Conformity {
	Conventional,
	Heterodox
}

var motivators = Motivator.keys()
var disposition = Disposition.keys()
var impulsiveness = Impulsiveness.keys()
var boldness = Boldness.keys()
var outlook = Outlook.keys()
var integrity = Integrity.keys()
var interactivity = Interactivity.keys()
var conformity = Conformity.keys()

func add_personality_traits_to(character):
	character.traits["motivator"] = motivators[randi()%(motivators.size()) - 1]
	character.traits["disposition"] = disposition[randi()%(disposition.size() - 1) - 1]
	character.traits["outlook"] = outlook[randi()%(outlook.size()) - 1]
	character.traits["impulsiveness"] = impulsiveness[randi()%(impulsiveness.size()) - 1]
	character.traits["boldness"] = boldness[randi()%(boldness.size()) - 1]
	character.traits["integrity"] = integrity[randi()%(integrity.size()) - 1]
	character.traits["interactivity"] = interactivity[randi()%(interactivity.size()) - 1]
	character.traits["conformity"] = conformity[randi()%(conformity.size()) - 1]
