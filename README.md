Project description.

Overview.

This project is base on Coordinator architecture (at the most simple level).

At project launch, the LaunchViewController is presented, from here the coordinator is instantiated.

The CountryCoordinator is created, upon creation, it push the ViewController to present, also create the NetworkManager and ask the network manager to get the JSON file from the network, base on the link provided. Use async / await to interact with the network manager, once that the net manager has the information back from the backend, the information is stored in the view model and the viewcontroller tableview is reloaded to present the information.

The CountryCoordinator, also has an observer to catch errors from the network manager and present an Alert View in case of any error, connecting to the back end.

The CountryCoordinator use snapshot to handle in a efficient way, the search bar to reload the tableview. 

The CountryViewModel handle the filtered of the data source and the number of rows on the data source.
