class_name Lantern
extends Area2D

# Define los posibles colores de la linterna
var color_rojo: Color = Color(1, 0, 0);  # Rojo
var color_amarillo: Color = Color(1, 1, 0);  # Amarillo
	
	
func prender():
	$ColorRect.color = color_amarillo;
	pass;
	
	
func apagar():
	$ColorRect.color = color_rojo;
	pass;
