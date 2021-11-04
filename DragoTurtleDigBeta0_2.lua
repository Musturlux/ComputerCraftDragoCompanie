--Mettre la tortue en bas a gauche

hauteur  = 0
longueur = 0
largeur  = 0
dg = 0 -- savoir si tourne droite(0) ou gauche(1)

-- -----
function creuse() -- crese ou detecter ne coute pas energie
	turtle.dig()
	turtle.forward()
end
-- -----


-- -----
function creuseLigne(longueur)
	
	carburant()
	
	for var = 1, longueur, 1 do
		creuse()
	end
	
	return 0
end
-- -----


-- -----
function goDroite()
	turtle.turnRight()
	creuse()
	turtle.turnRight()
end
-- -----


-- -----
function goGauche()
	turtle.turnLeft()
	creuse()
	turtle.turnLeft()
end
-- -----


-- -----
function creuseUneCouche(drga)

	for var = 1, largeur, 1 do
		
		creuseLigne(longueur - 1)
		
		if drga == 0 and var ~= largeur then
			goDroite()
			drga = 1
			
		elseif drga == 1 and var ~= largeur then
			goGauche()
			drga = 0
			
		end
	end
	return drga
end
-- -----


-- -----
function demandeUtilisateur(text)
	local reponse
	repeat
		io.write("Veillez entrez la " .. text .. " : ")
		io.flush()
		reponse = tonumber(io.read())
	until type(reponse) == "number"
	return reponse
end
-- -----


-- -----
function carburant()
	turtle.select(1)
	if turtle.getFuelLevel() < longueur+3 then
		turtle.refuel(math.ceil(longueur/80))
	end
end
-- -----


-- ---MAIN--- --
print("Placer la tortue un bloc au dessus du bloc le plus en bas a gauche.")
print("OUBLIER PAS LE CHARBON !!!!!")
hauteur  = demandeUtilisateur("Profondeur")
longueur = demandeUtilisateur("Longueur")
largeur  = demandeUtilisateur("Largeur")

turtle.refuel(1) -- fait 80 move pour du charbon
if turtle.detectDown() then
	turtle.digDown()
end
turtle.down()

for var = 1, hauteur, 1 do
	
	dg = creuseUneCouche(dg)
	
	if var ~= hauteur then
		if turtle.detectDown() then
			turtle.digDown()
		end
		turtle.down()
		turtle.turnLeft()
		turtle.turnLeft()
	end
end

turtle.select(1)
if turtle.getFuelLevel() < hauteur then
		turtle.refuel(math.ceil(longueur/80))
end

for var = 1, hauteur - 1 , 1 do
	turtle.up()
end

if turtle.detectUp() then
	turtle.digUp()
end
turtle.up()