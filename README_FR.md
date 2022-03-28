# API Tools

Explication de l'utilisation de la lib.

## Objectif

- Avoir une seule version d'Alamofire dans tous les projets.
- Créer rapidement les routes d'API.

## Créer une route API

Une route peut englober plusieurs cas, dans notre exemple la récupération des `Todos` peut se faire via la récupération de la liste ou d'un seul todo.

Les librairies nécessaires : 
```
import Api
import Alamofire
```

Création d'une route :

```
extension ApiRouter { // on extend la class du pod
    enum Todo: Route { // `Todo` = nom de ma nouvelle route
        case list // pour recuperer la list des todos
        case get(id: String) // pour recuperer une todo spécifique
```

Ensuite il suffit d'implémenter le protocol Route.
Exemple d'implémentation du code: `Api-Tools/Data/Api/ApiTodo.swift`

## Le call

Le call peut s'effectuer de trois manières :

```
// Décodage
public func call<R>(withCompletionCall completionCall: @escaping Api.Api.ApiResponse<R>) -> Alamofire.DataRequest? where R : Decodable, R : Encodable

// Traitement manuel du retour
public func call(withHandlerResult handlerResult: @escaping Api.Api.ApiResponse<Data>) -> Alamofire.DataRequest?

// Sans traitement sur le retour
public func call(withoutHandler handlerResult: @escaping Api.Api.ApiResponse<Void>) -> Alamofire.DataRequest?
```

Exemple d'implémentation du code : (cf. `Api-Tools/ViewController.swift`)
