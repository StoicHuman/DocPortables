{
//TODO=========== 🔎FUNCIONES 🔎===========
//* EJEMPLO 1

//se hacen en un objeto diferente para que no confunda con el cambio de nombre de javascript
function saludar ({name,age}:{name:string,age:string}){ 
    console.log(name,age)
}

// persona es un tipo objeto y condicionar el tipo de dato que retornara la funcion
function saludar2 (persona:{name:string,age:string}) : string{ 
    const {name,age} = persona
    console.log(name,age)
    return name
}

//* EJEMPLO 2

//En caso no queramos retornar nada en la funcion , el void le quita la importancia sobre que tipo de dato debes retornar ,"never" es para cuando si o si no quieres retornar nada.
const sayHiFromFunction = (fn:(name:string) => void) => {
    fn('joaquin')
}

const sayHi = (name: string ) => {
    console.log(`Hola ${name}`)
}

sayHiFromFunction(sayHi)

//Funcion que usaras casi siempre en el trabajo
function throwError(message:string): never {
    if(message) throw new Error(message);
    throw new Error(message);
}

//TODO=========== 🔎ARROW FUNCION 🔎===========

const sumar = (a:number,b:number):number => { //recomendada
    return a + b
}

const restar : (a:number,b:number) => number = (a,b) => {
    return a - b
}

}
{
//TODO=========== 🔎 Objetos - TypeAlias 🔎===========
    //->  si quiero colocar un hero.age = hola , no te dejara añadir ni aunque esta propiedad no exista , typescript es estricto
    let hero = {
        name : 'thor',
        age : 1500
    };
//========================
    // En cambio al crear un type , estamos haciendo un molde de un objeto el cual como se ve en la funcion copiamos , no importa el orden que uses las propiedades del type.
    type Hero = {
        readonly id?: number,
        name:string,
        age:number,
    //  isActive?: boolean  -> propiedad opcional
    }

    let hero2: Hero = {
        name: 'thor',
        age: 1500
    };

    // Si en caso agregamos isActive:true al return , nos daria error , debido a que se sale del molde de Hero , en cambio si es un propiedad opcional no daria error
    function createHero(name:string , age: number) :Hero {
        return { name , age }
    }
    const thor = createHero('Thor',1500)

    thor.id?.toString() //->  Como tenemos una propiedad opcional llamada ID en el molde HERO , TS añade el "?" para ejecutar el metodo en caso el valor del .id sea un number o un undefined

    //======================================

    function createHero2(hero: Hero) :Hero {
        const { name , age } = hero
        return {name , age }
    }    
    const thor2 = createHero2({name:'Thor',age: 1500})

    //? thor2.id = 13213124425345
    //              -> en el molde hero existe un "readonly" lo cual nos ayuda a prevenir mutabilidad que pueda romper el codigo (personas que cambien el valor a proposito como se ve en azul)

//TODO=========== 🔎  Objects - Template Union Types 🔎===========
//
// Tendremos como base la explicacion de los objetos 

type HeroId = `${string}-${string}-${string}-${string}-${string}`
type Hero1 = {
    readonly id?: HeroId, //Formato UUID
    name:string,
    age:number,
    isActive?: boolean  //-> propiedad opcional
}

let hero1: Hero1 = {
    name: 'thor',
    age: 1500
};

function createHero1(hero: Hero1):Hero1 {
    const { name , age } = hero
    return {
        id:crypto.randomUUID(),
        name,
        age,
        isActive:true
    }
}    
const thor1 = createHero1({name:'Thor',age: 1500})

//=================================================================
//* Ejemplo Concreto

// Template  Union Types es una tecnica para al igual que los objetos hacer un molde de un valor de dato , en este caso como los codigos de los colores son uniformes se puede aplciar uno

// a diferencia de "color" , color2 si cumple el formato del type por lo tanto no habra conflicto

type HexadecimalColor = `#${string}`

// const color :HexadecimalColor = '0033ff' 
const color2: HexadecimalColor = '#0033ff'

}
{
//TODO=========== 🔎 Union Types 🔎===========

type HeroId = `${string}-${string}-${string}-${string}-${string}`
type HeroPowerScale = 'local' | 'planetary'  | 'galactic' |'universal' |'multiversal'

let ann: number | string | 2 // union de 2 a mas tipos , osea que puede ser cualquier tipo de dato preestablecido o un valor como el "2"

const enableAnimationDuration: boolean | number = 200

type Hero3 = {
    readonly id?: HeroId
    name:string,
    age:number,
    isActive?: boolean
    powerScale?: HeroPowerScale //cualquier string de los 5 que se planteo en la parte de arriba
}

//TODO=========== 🔎 Intersection Types 🔎===========

// Se trata de dividir types con fines de practicidad
type HeroBasicInfo = {
    name: string,
    age:number,
}

type HeroProperties = {
    readonly id?: HeroId,
    isActive?:boolean,
    powerScale?: HeroPowerScale
}

type Hero = HeroBasicInfo & HeroProperties  //Unir ambos types

function createHero3(input : HeroBasicInfo):Hero {
    const { name , age } = input
    return {
        id:crypto.randomUUID(),
        name,
        age,
        isActive:true
    }
}    
const thor1 = createHero3({name:'Thor',age: 1500})
}
{
//TODO=========== 🔎 Type Indexing 🔎===========

// Utilizar un type por partes 

type HeroProperties2 = {
    isActive:boolean,
    address: {
        planet:string,
        city:string
    }
}

const addressHero:HeroProperties2['address'] = {
    planet:'Earth',
    city: 'Madrid'
}
/////////////

// Sacar el type de una variable 
const address = {
    planet:'earth',
    city:'madrid'
}

type Address = typeof address // el type quedaria :Object

const addressTwitch: Address = {
    planet:'mars',
    city:'Twitch'
}

/////////////

// Sacar el type de una funcion

function createAddress() {
    return {
        planet: 'Tierra',
        city:'Barcelona'
    }
}

type Address2 = ReturnType<typeof createAddress> // Object

}
//TODO=========== 🔎 Arrays 🔎===========

// Al declarar un array vacio sin tipo , TS lo toma como que siempre debe estar vacio y no deja agregar nada

const languages1: string[] = []
const languages2: (string | number)[] = []
const languages: Array<string>= []

languages.push('JavaScript')

type HeroBasicInfo = {
    name: string,
    age:number,
}

const herosWithBasicInfo: HeroBasicInfo[]= [] //Un array de objetos que esten como el molde type

/*
[
    ['X','O'.'Y'],
    ['O','Z'.'A'],
    ['C','V'.'A']
]
*/

type CellValue = 'X' | 'O' | ''

type GameBoard = [ //Tuplas - para definir la longitud de un array de array de strings
    [CellValue,CellValue,CellValue],
    [CellValue,CellValue,CellValue],
    [CellValue,CellValue,CellValue]
]
//const gameBoard: string[][] = ARRAY DE ARRAY DE STRINGS
//const gameBoard: CellValue[][] 
const gameBoard: GameBoard = [
    ['X','O','O'],
    ['O','X','O'],
    ['X','O','X']
]
//TODO=========== 🔎FUNCIONES 🔎===========

//TODO=========== 🔎FUNCIONES 🔎===========

//TODO=========== 🔎FUNCIONES 🔎===========

//TODO=========== 🔎FUNCIONES 🔎===========