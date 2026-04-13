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



