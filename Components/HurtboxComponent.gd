class_name HurtboxComponet extends Area3D

@export var health_component: HealthComponent

func damage(attack: Attack):
	if health_component:
		health_component.take_damage(attack.damage)
	if attack.interrupt:
		owner.state_machine.current_state.interrupt()
