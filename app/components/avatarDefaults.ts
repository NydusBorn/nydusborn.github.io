export interface AvatarShapeDefaults {
  petals: number
  foregroundColor: string
  backgroundColor: string
  rounding: number
  size: number | string
  petalThickness: number
  gearBaseThickness: number
  petalLength: number
  eyeWidth: number
  eyeHeight: number
  strokeWidth: number
  spinning: boolean
  isCircular: boolean
}

export const avatarDefaults: AvatarShapeDefaults = {
  petals: 12,
  foregroundColor: 'black',
  backgroundColor: '#f0f0f0',
  rounding: 4,
  size: 350,
  petalThickness: 0.75,
  gearBaseThickness: 15,
  petalLength: 25,
  eyeWidth: 90,
  eyeHeight: 50,
  strokeWidth: 6,
  spinning: true,
  isCircular: true
}
