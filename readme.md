# RefineryCMS Generators

Currently there are two generators, ``refinery_engine`` and ``refinery_form``. Read more about each below.

## Engine Generator

The Refinery generator is a standard Rails generator that functions just like the scaffold generator. It allows you to quickly add new managed sections to the Refinery backend and get the front end views for free.

To see how to use the generator run

    rails generate refinery_engine

Usage instructions should appear.

### Engine Generator Example

Let's say you have a client who has a range of products they want to show on their website. You've considered using a few pages to manage the products but you've decided it would be much nicer if there was a separate place that had forms dedicated to managing products.

First decide what fields they need to manage. In our case, the client is going to want to edit the title and description of each product. They would also like a little "facts panel" to show on the right of the page.

So go to the root of your project and run

    rails generate refinery_engine

This will output the help on how to use the generator. To generate the new section we want to manage products we run:

    rails generate refinery_engine product title:string description:text image:image brochure:resource

The generator will output a list of files it generated. You'll notice there is a new engine that has been added in ``vendor/engines/products``. This is where both the backend and front end files are held for this new products area.

Engines are treated like gems. When you generate a new engine it adds the gem dependency for this engine to the end of your ``Gemfile``. Because your ``Gemfile`` has changed you now need to run:

    bundle install

When the products engine was generated a products generator was also created. This installs any migrations and seeds into your Rails app. Here's how to finish off the install

    rails generate refinerycms_products
    rake db:migrate

Start up your app by running ``ruby script/server`` go to [http://localhost:3000](http://localhost:3000) and you'll see instantly a new menu item called "products". Click on that and you'll see there are no products yet.

Now go to the backend of your site by visiting [http://localhost:3000/refinery](http://localhost:3000/refinery) and logging in. You'll see a new tab called "Products", click on that and then click "Add a new product", fill the form and add an example product. Now go back to the front end and you'll see your product is showing up in the products part of your site.

Now you have a fully managed products section in Refinery, nice.

If you want to modify your generated engine you need to understand the basic structure of how they work.

See: [The Structure of an Engine](http://github.com/resolve/refinerycms/blob/master/vendor/refinerycms/core/engines.md)

## Forms Generator

Generates a custom forms based engine for Refinery automatically.
It works very similarly to the Refinery Engine generator.

The first string attribute should always be the one which is the title or name field in your model.

There must be at least one attribute.

### Additional Supported Field Types

  All field types that are supported by the Refinery Engine generator are supported
  with the addition of these form specific ones:

    radio           - creates a set of radio buttons based off Model::FIELD_NAMES
    checkbox        - creates a checkbox for true/false values.
    select          - creates a select list with options using Model::FIELD_NAMES

### Example

    rails generate refinery_form job_inquiry name:string message:text job_type:radio brochure:checkbox

