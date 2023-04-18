# Expert system for collectorsshop.ru

This program is a rule-based Prolog script that helps users find a specific Dota 2 in-game item (skin) based on a series of questions. The items have various properties, and the program asks the user whether the item they are looking for has a particular property or not.

The script defines properties and items with their associated properties. It uses a series of properties groups to ensure that only one property from each group is considered. It then uses a recursive process to ask the user questions about the properties of the item they are looking for. If the user answers 'yes' (or 'y') to a question, the property is added to their list of desired properties (Answers).

Once the program has gone through all the properties, it checks if there's an item that matches the user's specified criteria. If a match is found, it displays the name and price of the item. If no match is found, it continues with the next property.

The main function provides an interface for the user to start the search process or exit the program.
