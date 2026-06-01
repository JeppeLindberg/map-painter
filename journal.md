# Journal

## 26-04-06

Added resource tracking, and stub for resource trades


## 26-04-07

Added simple resource trading:
	Start of turn:
		creates resource packs on each tile
	End of turn:
		Deletes all resource packs, and add 0.1 ducats for each on blue tile

## 26-04-08

Oprettede indikator for capital cities

## 26-04-10

Oprettede manpower ressource og gjorde det muligt at tjene det via barracks

## 26-04-11

Oprettede UI elementer som skal kunne lave troops snart

## 26-04-13

Oprettede stump til at lave tropper

## 26-04-14

Refaktorede troops til at have en seperat node de kan være i i tiles

## 26-04-18

Kan nu lave troops :)

## 26-04-21

Det er nu muligt at lave fjende troops

Når en player troop står på en fjende troop, printer BATTLE

Klar til at implementere battles

## 26-05-02

Små UI ændringer

## 26-05-06

Lavede baseline battle prefab

## 26-05-14

Battle panels

## 26-05-17

Battle panels hooket op med morale + break

## 26-05-21

Troop counter viser nu korrekt tal + battle gør at troops ikke kan bevæge sig

## 26-05-23

BATTLES VIRKER NU

damage til player + enemy
classes til troops
refaktorering af troop kode

## 26-06-01

Battles kan nu konkludere med 1 side der bliver nødt til at retreat

# TODO

## Next:

Lav capitals

Lav enemies

Lav battles


## Resource trading, planned

End of turn:
	For each blue tile that consumes resources, allocate resources from resource packs, and send them to those tiles
	All remaining resource packs gets sold in trades
		Trades are determined by other factions, and what they need
		for now, 0.1 ducats for each 1 resource sold
	Unsold resources gets lost



