## R for modellers

These are slides, code and links to videos related to the use of the `R` programming language. This information is mainly geared towards mathematical modellers but may be useful to others. You will also find this useful if you are registered in one of the courses I teach at the University of Manitoba in which I require `R` coding, with some of the lectures being required reading/viewing in particular for [MATH 2740 (Mathematics of Data Science)](https://julien-arino.github.io/math-of-data-science/) students.

All files are available on the [GitHub version](https://github.com/julien-arino/R-for-modellers/) of the page. Feel free to use the material in these slides or in the folders. If you find this useful, I will be happy to know. Slides are produced mostly using [Marp](https://marp.app/), with a few using other systems (LaTeX, Sweave, Rmarkdown, etc.).

### "Vignettes"

Please note that the slides here are inherently a work in progress. I will be updating them from time to time to reflect a better understanding of the material, new packages, etc. 
Contrary to other courses I have posted, these are small snapshots ("vignettes") meant to illustrate a technique, so slide sets and videos vary greatly in length.
Also note that the order of the vignettes is, for the most part, not really relevant.

<ul>
{% for file in site.pages %}
  {% if file.path contains 'SLIDES' %}
    {% if file.path contains 'vignette' %}
      {% unless file.path contains 'FIGS' %}
        {% if file.path contains 'qmd' %}
          <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.name | remove: ".qmd" }}.html">{{ file.long-title }}</a>
          {% if file.youtube %}
            <a href="{{ file.youtube }}"> / Video</a>
          {% endif %}
          </li>
        {% endif %}
      {% endunless %}
    {% endif %}
  {% endif %}
{% endfor %}
</ul>


At present, there are no videos. I will be recording videos when time permits, probably in early 2024.

## Note pour les étudiants francophones

Je prévois de traduire les vignettes en français, mais cela prendra du temps. En attendant, si vous avez des questions, n'hésitez pas à me contacter.