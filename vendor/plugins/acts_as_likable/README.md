ActsAsLikable
=============

Allows user to like on the models.


Install
-------

Run the following command:
	ruby script/plugin install git://github.com/kitop/acts_as_likable.git
  
Generate and run the acts_as_likable migration
	ruby script/generate acts_as_likable_migration

Usage
-----

Make your ActiveRecord model act as likable.
	class Model < ActiveRecord::Base
	  acts_as_likable
	end

Credits
-------

Juixe.com - This project is heavily influenced by Acts As Votable
Esteban Pastorino
