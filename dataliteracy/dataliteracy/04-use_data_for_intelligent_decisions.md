<img width="150" style="float: right; margin: 0px 15px 15px 0px;" src="https://github.com/BuckWoody/presentations/blob/master/graphics/BWLogo002.png?raw=true"> 

# Workshop: Data Literacy

#### <i>Using Data To Make Intelligent Decisions</i>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>4 - Using Data for Intelligent Decisions</h2>

In this workshop you'll cover using data to make intelligent decisions. In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic.

(<a href="https://github.com/BuckWoody/presentations/blob/master/dataliteracy/dataliteracy/00-pre-requisites.md`" target="_blank">Make sure you check out the <b>Pre-Requisites</b> page before you start</a>. You'll need to complete the work there before you can proceed with the workshop.)

<p style="border-bottom: 1px solid lightgrey;"></p>

A military colonel named [John Boyd](https://duotechservices.com/10-things-you-didnt-know-about-col-john-boyd) was asked to examine a problem involving combat situations. Even with proper training and skills, casualty rates were too high. Col. Boyd looked at the [root causes](https://asq.org/quality-resources/root-cause-analysis), and found that there was not a structured way for a soldier to make a decision in the field on what to do – when under attack, they began to defend themselves immediately, resulting in poor decisions.

Col. Boyd developed a method of deciding on an action that was simple, could be learned and memorized easily, and used for tasks that took long periods of time or when someone needs to react in seconds. It’s called the “OODA Loop”, which stands for “Observe, Orient, Decide, Act”. It’s a systematic process you can use for almost anything – and [you can learn more about it here](https://en.wikipedia.org/wiki/OODA_loop).

This type of structure is also applicable to Data Literacy. You’ve learned the basics of researching and locating data, how to verify the data, tools you can use to gather and manipulate the data, and the processes and procedures for analyzing data. In a way, you’ve done the two “O’s” in the OODA loop. Now you’re ready to apply the analysis to make a decision. The point of OODA is to take time and apply a process to a decision, the same thing you need to do with using data for intelligent decisions.

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">4.1 Understanding the Problem</h2>

The [first place to start is with the problem itself](https://www.toolshero.com/problem-solving/problem-definition-process/). Many times – but not all – a problem drives the data research to start with. the most important question about the problem is: Is it properly defined? Assume you’re in a car, and you say to the driver “are we making good time?” and the driver checks the speedometer and answers “yes”. You sit back, confident that you’ll make the meeting. Later you say “are we nearly there?” and the driver says “yes”. Then he drops you off at the wrong address. The better question should have been “when will we arrive at this address?”

That may be a trivial example (although I’ve had it happen more times than I care to admit) but the same mistake is often made in much more important situations, by trained professionals.

The bigger point is to [ensure that you’ve asked the right question](https://docs.microsoft.com/en-us/archive/blogs/buckwoody/the-hardest-thing-in-data-science). You can often uncover the right question by asking another question: “When we get the answer from the data, what will we do about it?” In the trivial example mentioned earlier, we might find out that asking the speed of travel is only half the information we need – and that the action of arriving at the right destination at the right time would be the goal. That drives a different question – “When will we arrive at destination X?” Which is in fact the right question for the problem you are trying to solve.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">4.2 Applying the Proper Data and Analysis to the Problem</h2>

Earlier you learned about [the importance of data quality – ensuring that the proper comparisons are made](https://smartbridge.com/data-done-right-6-dimensions-of-data-quality/). For instance, ensuring that the same [data types (inches, centimeters, dates, volumes, etc.) are applied](https://www.newscientist.com/article/mg12717301-000-the-testing-error-that-led-to-hubble-mirror-fiasco/) to the transformations is vital. It’s equally important to ensure that the data you’re using supports the analysis for the solution to the problem you are solving. Refer back to the last article on Cognitive Biases to see examples of using one data set to answer a problem it doesn’t support.

What is true for data is true for the analytic process. Earlier you learned that a scientific method involves steps that aren’t included in other types of analysis, such as creating an initial hypothesis, creating control groups and so on. Ensure that the analytic process is appropriate to [the problem domain](http://www.site.uottawa.ca/~laganier/seg2500/cemdomain.htm) you are working in.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">4.3 Consider the Alternatives</h2>

Perhaps more than any other error in applying analysis to reach a conclusion is not including other alternatives in your decisions. Once again, [the Cognitive Biases](https://www.translatemedia.com/us/blog-us/cognitive-biases-influence-decision-making/) come into play – it’s common to get a solution we think is perfect, and then make the data and analysis fit that solution. By considering other alternatives, performing a cost/benefit analysis, and risk/reward types of processes, you can either support your conclusion as the right one, or allow you to change your conclusion before you make a decision.

Note that sometimes constraining factors will affect the quality of the decision. If you have only a few seconds to decide, a full set of research isn’t possible. If you have [limited funds and time, the decision is affected by those constraints](https://www.gamified.uk/2013/08/05/the-effect-of-time-on-decision-making/). It’s important to push back as much as possible on those constraints, however. There’s never enough time to analyze all the data and perform all the analysis, but you should do the best you can to get as much data and analysis as is possible.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">4.4 Explain the Solution</h2>

Even if you’re using data and analytics to make a decision for yourself, you should be ready to explain it to someone else. This is the final check you should make before you take action. If the decision affects others, it’s essential to create a presentation of some sort (an e-mail or other written document, a presentation, Notebook, or graphic) to discuss with others – as many others as are affected by the decision as possible.

[Documenting your sources and methods](http://libguides.mst.edu/c.php?g=335446&p=2257031) allows for good communication, understanding, debate and inclusion. It also allows others to reproduce and check your work, something you should seek out.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">4.5 Learning from Mistakes</h2>

No matter how much time you spend in your data and analytics, you will make a mistake. That’s OK – everyone makes mistakes, particularly if they are tasked with making big decisions a lot. [The important thing is not the mistake](https://blog.iqmatrix.com/learn-from-mistakes) – the key is learning from the mistake, and incorporating that data back into your next analysis. 

This is the end of this short article on Data Literacy – please check the links throughout the text, and spread the article widely. If there’s anything the world needs, it’s more concern for each other, and part of that concern is to make wise decisions for us all. Data Literacy is a pathway to doing just that.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="url" target="_blank">TODO: Enter courses, books, posts, whatever the student needs to extend their study</a></li>
</ul>

Open Data Initiative – https://www.microsoft.com/en-us/open-data-initiative
5 Data Sources online – https://ijnet.org/en/story/5-ways-find-sources-online
Society of Professional Journalists - https://www.spj.org/index.asp 
Fact Checking: Think like a Journalist – https://www.sciencenewsforstudents.org/blog/outside-comment/fact-checking-how-think-journalist
US Government Data – https://www.data.gov/
Google’s Public Data Explorer – https://www.google.com/publicdata/directory#!


Congratulations! You have completed this workshop on <TODO: Enter workshop name>. You now have the tools, assets, and processes you need to extrapolate this information into other applications.