# Articles with Images

This repository contains a subset of a Ruby on Rails app. There are 3 models.
`Articles` are a type of `Posting`. Other types of Postings include `Questions` and `ProductReviews`. 
Postings have a `body` attribute. The contents of the Posting is stored as raw html. Some Postings have images embedded within the text of the Posting, in the form of an `<img>` tag wrapped in `<figure>` tags.

The repo also contains one view file and one spec file.

## The Task
Throughout the site, "posting snippets" are displayed, with links to read the full Posting. The product manager has decided that when an Article contains an image, its snippet should display the image above the snippet body. If an Article contains multiple images, only the first image should be displayed.

## Your Task
You are the developer assigned to review the code that was created for this feature. As you review the code, try to answer the following questions:

- Does the implementation achieve the desired effect?
- What are the shortcomings of this implementation?
- Does the code adhere to best practices?
- How might you implement this differently?

#### RSpec
The code includes a unit test, which passes. What is wrong with this unit test? How could it be improved?

### Instructions
Fork this repository. You can either add comments to the existing code explaining what is wrong and/or what you would change and why. Or you can rewrite the feature, highlighting in the comments what was problematic with the original implementation and providing justification for your decisions. Please put a link to your public repository into the answer section of the question.


### Response
1. Does the implementation achieve the desired effect? - Yes, but only in case when we have "figure" and "img" tags inside body.
2. What are the shortcomings of this implementation? - Sometime the "article_with_image" method return hash but sometimes strings, so here is the problem. We not expect a string in the view.
3. Does the code adhere to best practices? - I would say no.
4. How might you implement this differently? - First of all I would start from the unit test. It's a good practice to write it before the implementation. So using TDD here we would prevent exeptions in case of unexpected type. I mean in view we expect hash but sometimes getting string. I would add more cases into it. For example is case if the "figure" tag is missing or the "img" tag is missing. Also we should handle cases when a method returns a sting.