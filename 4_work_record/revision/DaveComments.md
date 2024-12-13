## 07-03-2024

```
Hi Yuan,

I have gone through the paper several times.  My comments were on a range of levels, from the small to the large.  I wouldn't say that my comments are comprehensive and captured all the issues that need addressed, but they capture the spirit of the kind of revisions that are needed before submission.

Probably most important before sending the manuscript to the coauthors are the following.

1. The methods section needs to be more structured so that the reader knows what this contains.  The order should make conceptual sense, too, in how the model is set up, initialized, and run, as well as the changes that you implemented to the code.  It also needs a clear and ordered description of the model simulations (unless I missed it in the paper somewhere).

2. The results section is similarly not signposted well.  It opens abruptly, and I often feel that I don't know why figures and results are being presented at me.  I'm not being taken on a journey and explained where we are going and how we will get there.

3. Decide what to do with the appendices.  Either they need to be brought into the manuscript or they need to be deleted.  I don't see any of these as viable candidates for appendices.  I could be wrong, but that's my impression.

4. All multi-panel figures should have panels labeled (a), (b), (c), etc.  When discussing specific results in the text that pertain to specific figure panels, those specific figure panels should be cited within each sentence.  Otherwise, the reader is lost.

5. In one location, I ran your paragraph through the free version of ChatGPT and asked for it to be improved.  You can see the result.  It is improved, but not perfect.  I don't know what you and Zhonghua think about this as a strategy, but it is something that you may wish to consider.

6. Is there a reason that the endpoint is 2099?  Why not choose something more urgent and within our lifetimes (e.g., 2050)?

7. I think the discussion section should be separated from the conclusion section.  See Eloquent Science, sections 4.10 and 4.11.

Eventually, before submission, you will also need to make other changes, as well.  See my comments on Overleaf for further issues that need addressing.

If you have any questions, please let me know.

Best regards,

Dave
```

## 12-03-2024

```
The manuscript should defend your choices.

Do we have information on how quickly a city can change its albedo?  In other words, can you put it into context?  What fraction of roofs would have to be painted white for Barcelona or London to increase its albedo by 0.1?  Is it a linear increase in terms of effort?

Although cities will still be around in 2099, I think it is worth thinking about how quickly these changes could be made in the near-term and midterm periods.  That is when we will cross 1.5 or 2.0 degrees warming.  That is wen we will be around on this planet to experience things.  How much difference can we make now to ensure that it happens sooner than later?

Best,

Dave
```

## 14-03-2024

```
This is all fine, but perhaps you are missing my larger point about how we do science and why.  Let me try to be more clear.

We do science, in part, to make a better world for ourselves and our society.  Climate change and its impacts are a pressing problem, and you have the skills and talents to do research that informs society of steps that they could do to reduce the impacts in urban areas.  So, does your research help inform us, improve our lives, give us hope that we can do something positive to reduce climate impacts?

Yes, the model is coarse, but that is the tool that you have chosen to do your research. I have challenged you all along whether this is the right tool for the job, but the decision seems to have been made.  So, we persist in doing urban climate experiments with a global Earth system model that cannot fully resolve the cities.

The beauty of model simulations is that you have control over the scenarios you want to choose through your choice of initial conditions, the various settings, and the subroutines you write to alter the parameterizations.  But, there are people who have all this wonderful ability to perform experiments, and just flip switches because (i) it's easy, (ii) they want a quick publication, and (iii) the field does not push them to be more innovative in their choice of experimental design.  I hope that I can influence you not to fall into this trap of "just because you CAN do something does not mean that you SHOULD do it".  The journals are littered with papers that did exactly that; they will rarely be cited, and they will have no impact on making the world a better place.

When doing science, it makes sense to do reasonable experiments that represent plausible scenarios that could occur.  Sometimes we do experiments that are extreme or impossible to see how far we can push the climate system or the modeling system, but when we do so we say exactly why we are doing these experiments.  One type of experiment that I like to do is "what is the worst that could happen?"  If we set the conditions to produce the worst-case scenario, what do we get?  It's an extreme endmember, but it allows us to set possible bounds on the worst-possible outcome and impacts.

In your paper, you write this is what the paper will do:  "we leverage the state-of-the-art Earth system model, CESM, to simulate the phased introduction of high-albedo interventions in urban environments."

In the paper, you set a maximum urban albedo at 0.9 because that is what other studies have done.  That's fine.  Say that this is a hypothetical best-case scenario.  But, what is the current value of albedo, and how long would it take to raise the albedo of the roofs by 0.01 each year?  Readers will not have context for this.  I know you say that you cannot resolve these city-level changes, but you have to be able to explain your experiment to your readers.  You have to give them context for what this means in practice.  Without this information, all you are doing is flipping switches in a hypothetical model world and leaving no space for readers to believe that your results are important in the end.  We don't want to do that.

I would ask you to consider whether there is a way to communicate what 0.01 increment means in reality.  Doing so will help readers better understand your work.

Also, if one paper looks at a linear increase of albedo over time and a second paper looks at a nonlinear increase over time, then this is too small an increment in knowledge.  If you think the nonlinear increase is important and more realistic, then you should include these experiments within this present manuscript so that a direct comparison can be made.  Writing a number of papers with small increments in knowledge that should have been discussed together in one paper is called salami slicing.  (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3900084/, as one example.). Most scientific authors view salami slicing as unethical.  

It may be that you have a better design for this next paper that involves a range of different experiments that provides a much greater increment in knowledge.  If so, that's fine.  But, I want you to understand where I stand on this point.

As always, let me know if you have any questions.

Best wishes,

Dave
```

## 14-03-2024

```
Hi Yuan,

Great to hear.  I like that phrase "play Fortran programming games".  

It's always better to get the science and the manuscript right first before submission.  Not doing that can lead to worse problems than just getting rejected.

Anything you can do in the manuscript to justify your choices of the global Earth system model in general, the CESM in particular, and the settings for the various experiments that you perform will improve the manuscript.  Do not be afraid to explicitly state the limitations/assumptions of your study in the manuscript.  It is better for you to say what the limitations/assumptions are than have reviewers identify them and recommend rejection because you didn't take them into account.

Like I said, the choice of a global model to be run for this experiment is one of those big assumptions that reviewers will rightfully question.  Be sure that you have a good rationale in the manuscript for why you did it this way.

Hope that helps!

Best wishes,

Dave
```
