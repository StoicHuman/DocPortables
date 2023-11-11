//TODO=========== 🔎 Enums / Enumeraciones 🔎===========
//* Depende de la manera en que lo hagas , se va a poder compilar en codigo JavaScript
//* Se usan para un control de datos Finitos y puedas controlarlos 

// ? JavaScript
const ERROR_TYPESJS = { 
    NOT_FOUND: 'notFound',
    UNAUTHORIZED: 'unauthorized',
    FORBIDDEN: 'forbidden'
}

function mostrarMensajeJS(tipoDeError) {
    if(tipoDeError == ERROR_TYPESJS.NOT_FOUND) {
        console.log('No se encuentra el recurso')
    } else if (tipoDeError == ERROR_TYPESJS.UNAUTHORIZED){
        console.log('No tienes permisos para acceder')
    }else if (tipoDeError == ERROR_TYPESJS.FORBIDDEN) {
        console.log('No tienes permisos para acceder')
    }
}
//? TypeScript
// Hay 2 maneras de manejar los datos de un enum , tanto colocando const antes del enum (lo cual vuelve los valores del enum como inmutables y no se podra cambiar despues de definirlas ) o en el if comparar con los valores que le da js al traspilar 0,1,2,etc como si fuera su indice
enum ERROR_TYPESTS { 
   NOT_FOUND= 'notFound',
    UNAUTHORIZED= 'unauthorized',
    FORBIDDEN = 'forbidden'
}

function mostrarMensajeTS(tipoDeError: ERROR_TYPESTS) {
    if(tipoDeError === ERROR_TYPESTS.NOT_FOUND) {
        console.log('No se encuentra el recurso')
    } else if (tipoDeError === ERROR_TYPESTS.UNAUTHORIZED){
        console.log('No tienes permisos para acceder')
    }else if (tipoDeError === ERROR_TYPESTS.FORBIDDEN) {
        console.log('No tienes permisos para acceder')
    }
}

//TODO=========== 🔎 Aserciones de Tipos 🔎===========
/*
* Al momento de tratar con typescript lo que es Manejo del DOM , tendremos complicaciones , TS solo funciona en compilacion mas no en ejecucion 
*/

const canvas = document.getElementById('span') //TS no tienen ni idea si el elemento existe o no 

// Esta validacion es JAVASCRIPT puro , asi que como ts no puede saber si el elemento existe , al compilarse a codigo JS este si lo leera la condicion y lo ejecutara en caso se cumpla
if(canvas instanceof HTMLCanvasElement) {
    const ctx = canvas.getContext('2d')
}

//TODO=========== 🔎 Fetching de datos API 🔎===========
// cambiar la extension .ts por .mts para hacer modulos 
// En la API que quieres consumir , haces una peticion cualquiera y lo que te devuelve lo pegas en la pagina quickType marcas las opciones si lo quieres con interfaces , enum , types etc 

//? EJM de que nos daria quicktype
export type GitHubAPIResponse = {
    total_count: number;
    incomplete_results: boolean;
    items: Item[];
}

export type Item = {
    id: number;
    node_id: string;
}

const APIURL = "urletc"

const response = await fetch(APIURL)

if(!response.ok){
    throw new Error ('Request Failed')
}

const data = await response.json() as GitHubAPIResponse //Nos facilita la validacion para javascript puro

// como ya todo esta tipado , nos reconoce los datos que estamos accediendo 
data.items.map(repo => {
    return {
        id: repo.id,
        nodeid: repo.node_id
    }
})

//TODO=========== 🔒 INTERFACE 🔒 ===========

//Cumple el mismo funcionamiente que un type, en ser un molde para un objeto en temas de types 

// Pueden estar anidadas osea una interface dentro de otra interface 

// la diferencia con los types es que interface puede hacer un "extends"

// otra diferencia es que se puede dividir , osea que por ejemplo Carrito Ops, puedo volver a declararla mas abajo pero añadirneod una funcion ejemplo "delete" y al usarlo se juntaran ambas instancias de Carrito Ops haciendolo 1 solo (no se recomienda por que puede desordenar el codigo)

//* Segun midudev , con types podemos hacer un formato mas completo en el caso de una propiedad de un objeto (dicho type puede hacer consumido por una interface )y tambien se puede moldear un array , en cambio con interface son netamente para objetos/clases

interface Producto {
    id: number,
    name: string ,
    age: number, 
    quantity: number
}

interface Zapatilla extends Producto {
    talla: number
}

interface CarritoDeCompras {
    totalPrice: number
    productos: (Producto|Zapatilla)[]
}
//? Manera 1 de aplicar funciones en interfaces
// interface CarritoOps {
//     add:(product:Producto)=> void,
//     remove:(id:number)=> void,
//     clear:()=> Void
// }

//? Manera 2 , mas recomendada
interface CarritoOps {
    add(product:Producto):void
    remove(id:number):void
    clear(): void 
}

const carrito: CarritoDeCompras = {
    totalPrice: 100,
    productos: [
        {
            id: 1,
            name: 'string' ,
            age: 100, 
            quantity: 1, 
            talla:5  
        }
    ]
}


//TODO=========== 🔎 NARROWING 🔎===========
//      -> Se refiere cuando una variable puede ser de 2 tipos sin embargo usas el metodo de alguno de ellos lo cual puede romper el codigo .

function mostrarLongitud(objeto: number | string ){
    
    if(typeof objeto == 'string'){ //Para evitar el conflicto se limita a hacer una condicion para uno de ellos 
        return objeto.length
    }

    return objeto.toString().length // Si el codigo llega aqui , significa que el type es number
}

//===========================================================================

interface Mario {
    company: 'nintendo', //Al darle un valor en concreto significa que siempre sera este valor y no puede cambiar
    nombre: string,
    saltar:() => void
}

interface Sonic {
    company: 'sega',
    nombre:string,
    correr:() => void
}
 
type Personaje = Mario | Sonic

//typeguard : dejame comprobar si el personaje es sonic "is/as sonic" , tratar de evitarlo porque hace que el codigo de vuelva muy verboso y se tendrian que hacer muchas comprobaciones en un entorno real. 

function checkIsSonic(personaje: Personaje): personaje is Sonic {
    return (personaje as Sonic).correr !== undefined //Devuelve true o false
}

function jugar(personaje: Personaje){

    // if(personaje.company == 'nintendo'){ 
    //     personaje.saltar()
    //     return// el return hace que el codigo se detenga aqui y no haga conflicto con el .correr
    // }
    // personaje.correr()

    if(checkIsSonic(personaje)){
        personaje.correr()
        return
    } else {
        personaje.saltar()
        return
    }
}


    
//TODO=========== 🔎Instance OF / Class🔎===========

/*
    La propiedades de avenger , name power etc al no tener cifrado pueden ser accedidas desde fuera mutando los datos de la instnacia hecha , por lo tanto las opciones que tenemos es colocar "#name"(javascript) , private(TypeScript) , protected -> es privado pero puedes acceder al mismo pero de una clase externa que este heredando de la principal.

    * Buscar ejemplos de Clases usando interfaces 
*/

class Avenger {
    //tipado
    readonly name: string 
    private powerScore: number
    private readonly wonBattles: number = 0

    constructor(name:string,powerScore:number){
        this.name= name 
        this.powerScore= powerScore
    }

    get fullName() {
        return `${this.name}, de poder ${this.powerScore}`
    }

    set power(newPower:number){
        if(newPower <= 100) {
            this.powerScore = newPower
        } else {
            throw new Error ('Power score cannot be more than 100')
        }
    }
}

const avengers = new Avenger('Spidey', 80)





//TODO=========== 🔎 convencion .d.ts 🔎===========
    //Mas que todo es porque cuando un archivo que sera netamente declaraciones de interfaces , clases  etc  pueden ir aqui , funciones no , nada de codigo logico puede ir aqui.

//TODO=========== 🔎FUNCIONES 🔎===========


//TODO=========== 🔎FUNCIONES 🔎===========
