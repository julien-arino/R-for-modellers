## R for modellers

These are slides, code and links to videos related to the use of the `R` programming language. This information is mainly geared towards mathematical modellers. However, you will also find this useful if you are registered in one of the courses I teach at the University of Manitoba in which I require coding.

On the [GitHub version](https://github.com/julien-arino/R-for-modellers/) of the page, you have access to all the files. You can also download the entire repository by clicking the buttons on the left. (You can also of course clone this repo, but you will need to do that from the GitHub version of the site.)

Feel free to use the material in these slides or in the folders. If you find this useful, I will be happy to know. Slides are produced mostly using [Marp](https://marp.app/), with a few using other systems (\LaTeX, Sweave, Rmarkdown, etc.).

### Slides

Please note that the slides here are inherently a work in progress. I will be updating them from time to time to reflect a better understanding of the material, new packages, etc. 
Contrary to other courses I have posted, these are small snapshots meant to illustrate a technique, so slide sets and videos vary greatly in length.
Also note that the order of the "lectures" is, for the most part, not really relevant and is included mostly for my convenience.

<ul>
{% for file in site.static_files %}
  {% if file.path contains 'SLIDES' %}
    {% if file.path contains 'vignette' %}
      {% unless file.path contains 'FIGS' %}
        {% if file.path contains 'pdf' %}
          <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.basename }}.pdf">{{ file.basename }}</a></li>
        {% endif %}
        {% if file.path contains 'html' %}
          <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.basename }}.html">{{ file.basename }}</a></li>
        {% endif %}
      {% endunless %}
    {% endif %}
  {% endif %}
{% endfor %}
</ul>

At present, there are no videos. I will be recording videos when time permits, probably in early 2024.