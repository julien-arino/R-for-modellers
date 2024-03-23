## R for modellers

These are slides, code and links to videos related to the use of the `R` programming language. This information is mainly geared towards mathematical modellers but may be useful to others. If you are registered in one of the courses I teach at the University of Manitoba in which I require `R` coding, some of the vignettes are required reading, e.g., for [MATH 2740 (Mathematics of Data Science)](https://julien-arino.github.io/math-of-data-science/) students.

All files are available on the [GitHub version](https://github.com/julien-arino/R-for-modellers/) of the page. Feel free to use the material in these slides or in the folders. If you find this useful, I will be happy to know. Slides are produced mostly using [Marp](https://marp.app/), with a few using other systems (LaTeX, Sweave, Rmarkdown, etc.).

### "Vignettes"

These are small snapshots ("vignettes") meant to illustrate a technique.
Material here is inherently work in progress. 
I will be updating the vignettes from time to time to reflect a better understanding of the material, new packages, etc. 
The vignettes and videos vary greatly in length.
Their order is, for the most part, not really relevant.

Vignettes for which videos are available are marked with a YouTube logo and are more complete than those without.

<ul>
{% for file in site.pages %}
  {% if file.path contains 'SLIDES' %}
    {% if file.path contains 'vignette' %}
      {% unless file.path contains 'FIGS' %}
        {% if file.path contains 'qmd' %}
          <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.name | remove: ".qmd" }}.html">{{ file.long-title }}</a>
          {% if file.youtube %}
            <a href="{{ file.youtube }}"><img src="assets/img/yt_logo_rgb_light.png" height="15px" /></a>
          {% endif %}
          </li>
        {% endif %}
      {% endunless %}
    {% endif %}
  {% endif %}
{% endfor %}
</ul>


## Note pour les étudiants francophones

Je prévois de traduire les vignettes en français, mais cela prendra du temps. En attendant, si vous avez des questions, n'hésitez pas à me contacter.