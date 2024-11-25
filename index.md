# R for modellers

These small snapshots ("vignettes") illustrate techniques in `R`.
This information is mainly geared towards mathematical modellers but may be useful to others. 

If you are registered in one of the courses I teach at the University of Manitoba in which I require `R` coding, e.g., [Mathematics of Data Science (MATH 2740)](https://julien-arino.github.io/math-of-data-science/), some of the vignettes are required material.

Slides are produced using [Quarto](https://quarto.org/).
Slide sources and all the code used are available on the [GitHub repo](https://github.com/julien-arino/R-for-modellers/). Feel free to use any material; if you find this useful, I will be happy to know. 

Material here is inherently work in progress. 
I will be updating the vignettes from time to time to reflect a better understanding of the material, new packages, etc. 
The vignettes and videos vary greatly in length.
Their order is not relevant and somewhat random.

When present, the YouTube logo points to the video of the vignette. Those vignettes for which a video is available are more complete than those without.

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

## Transversal lectures

I have started preparing some lectures that take a transversal approach, digging into one topic in detail using a variety of techniques illustrated in the vignettes above. For the time being, there is a single such lecture here, but I aim to make others. (If you have a request for a topic, feel free to get in touch.)

- [Basic computational analysis of a model](https://julien-arino.github.io/R-for-modellers/SLIDES/basic-computational-analysis.pdf). Note that this is work in progress.


## Note pour les étudiants francophones

Je prévois de traduire les vignettes en français, mais cela prendra du temps. En attendant, si vous avez des questions, n'hésitez pas à me contacter.