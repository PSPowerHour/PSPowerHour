---
theme : "moon"
transition: "zoom"
highlightTheme: "hopscotch"
---

# PS PowerHour

### PowerShell Getters and Setters and why we should use them

<small>Created by [Ryan Bartram](http://dftai.ch) / [@rd_bartram](http://twitter.com/rdbartram)</small>

---

## Hello There
<a href="0" class="navigate-down">
    <img width="238" height="238" data-src="https://pbs.twimg.com/profile_images/886674786759397378/-sfRkbYN_400x400.jpg" alt="header">
</a>

my name is Ryan, I blog  at dftai.ch almost never :).
But I do never forget to automate it.

---

## What are accessors?

--

They are a way to control <span class="fragment highlight-green">*access*</span>
to properties or methods in a class/function etc

--

## Getters

You use getters to <span class="fragment highlight-green">control</span> what data gets <span class="fragment highlight-green">returned</span>.
Sounds obvious, an examples would be return a *fullname*.

```powershell
    return "{0} {1}" -f $this.firstname, $this.surname
```
  <!-- .element: class="fragment fade-up" -->

--

## Setters

You use setters to <span class="fragment highlight-green">control</span> what data gets <span class="fragment highlight-green">written</span> to a variable.
This could be something as simple as trimming whitespace.

```powershell
    $this._internal =  $args.Trim() 
```
  <!-- .element: class="fragment fade-up" -->

---

## Accessors in PowerShell

Unfortunately, today we don't have alot of native control over how our 
properties are accessed. 

--

## the workaround

--

## Script Property
  <!-- .element: class="fragment fade-up" data-autoslide="1000" -->

## &
  <!-- .element: class="fragment fade-up" data-autoslide="1000" -->

## hidden
  <!-- .element: class="fragment fade-up" data-autoslide="2000" -->


--

<!-- .slide: data-background="http://i.giphy.com/90F8aUepslB84.gif" -->

---

## Demo Time
