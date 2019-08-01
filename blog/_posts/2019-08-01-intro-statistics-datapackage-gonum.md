---
 author: {Daniel Fireman}
 username: {danielfireman}
 title: {Introduction to Statistics With Data Packages and Gonum}
---

After 6 years at Google, Daniel Fireman is currently a Ph.D. student, professor and activist for government transparency and accountability in the Northeast of Brazil. He was one of the 2017's Frictionless Data Tool Fund grantees and implemented the core Frictionless Data specification in the [Go](https://golang.org/) programming language: [datapackage](https://github.com/frictionlessdata/datapackage-go) and [tableschema](https://github.com/frictionlessdata/tableschema-go), which he still maintains. You can read more about this in [his grantee profile](https://frictionlessdata.io/articles/daniel-fireman/).

Since its first release in 2017, we've been improving [datapackage](https://github.com/frictionlessdata/datapackage-go) and [tableschema](https://github.com/frictionlessdata/tableschema-go) packages. Besides fixing bugs, we tried to make it easier to use data packages together with statistical/plotting libraries like [Gonum](https://gonum.org/). This post shows an example of such usage and was inspired in [this](https://sbinet.github.io/posts/2017-10-04-intro-to-stats-with-gonum/) post, from [Sebastian Binet](https://github.com/sbinet).

---

Our goal in this tutorial is to load a data package from the web and use [Gonum](https://gonum.org/) to calculate some basic statistics.

## Go, Data Packages & Gonum

[datapackage](https://github.com/frictionlessdata/datapackage-go/tree/master/datapackage) is _"a package for working with [Data Packages](http://specs.frictionlessdata.io/data-package/)"_. A Data Package consists of:

- Metadata that describes the structure and contents of the package
- Resources such as data files that form the contents of the package

[Gonum](https://gonum.org/)  is  _"a set of packages designed to make writing numeric and scientific algorithms productive, performant and scalable."_

Before being able to use `datapackage` and  `Gonum`, we need to install  [Go](https://golang.org/). We can download and install the  `Go`  toolchain for a variety of platforms and operating systems from  [golang.org/dl](https://golang.org/dl). This post assumes the installation of version 11 or newer.

After installing Go, the runtime will download `Gonum`, `datapackage` and all its dependencies as part of running the go script.

## Reading Datapackage

In this post, we are using a [Tabular Data Package](https://frictionlessdata.io/specs/tabular-data-package/) containing the periodic table. The package descriptor ([datapackage.json](https://raw.githubusercontent.com/frictionlessdata/example-data-packages/62d47b454d95a95b6029214b9533de79401e953a/periodic-table/datapackage.json)) and contents ([data.csv](https://raw.githubusercontent.com/frictionlessdata/example-data-packages/62d47b454d95a95b6029214b9533de79401e953a/periodic-table/data.csv)) are stored on [GitHub](http://github.com/). This dataset includes the atomic number, symbol, element name, atomic mass, and the metallicity of the element. Let's start by taking a quick look at the header and the first rows.

```go
// file: stats.go

package main

import (
    "fmt"

    "github.com/frictionlessdata/datapackage-go/datapackage"
)

func main() {
    pkg, err := datapackage.Load("https://raw.githubusercontent.com/frictionlessdata/example-data-packages/62d47b454d95a95b6029214b9533de79401e953a/periodic-table/datapackage.json")
    if err != nil {
        panic(err)
    }
    res := pkg.GetResource("data")
    table, err := res.ReadAll()
    if err != nil {
        panic(err)
    }
    for i := 0; i < 4; i++ {
        fmt.Println(table[i])
    }
}
```

## Gonum and statistics

Gonum provides many statistical functions. Let’s use it to calculate the mean, median, standard deviation and variance of the atomic masses.

```go
// file: stats.go

package main

import (
        "fmt"
        "math"
        "sort"

        "github.com/frictionlessdata/datapackage-go/datapackage"
        "github.com/frictionlessdata/tableschema-go/csv"
        "gonum.org/v1/gonum/stat"
)

func main() {
        pkg, err := datapackage.Load("https://raw.githubusercontent.com/frictionlessdata/example-data-packages/62d47b454d95a95b6029214b9533de79401e953a/periodic-table/datapackage.json")
        if err != nil {
                panic(err)
        }
        var masses []float64
        res := pkg.GetResource("data")
        if err := res.CastColumn("atomic mass", &masses, csv.LoadHeaders()); err != nil {
                panic(err)
        }
        fmt.Printf("data: %v\n", masses)

        sort.Float64s(masses)
        fmt.Printf("data: %v (sorted)\n", masses)

        // computes the weighted mean of the dataset.
        // we don't have any weights (ie, all weights are 1)
        // so we just pass a nil slice.
        mean := stat.Mean(masses, nil)

        // computes the median of the dataset.
        // here as well, we pass a nil slice as weights.
        median := stat.Quantile(0.5, stat.Empirical, masses, nil)

        variance := stat.Variance(masses, nil)
        stddev := math.Sqrt(variance)

        fmt.Printf("mean=     %v\n", mean)
        fmt.Printf("median=   %v\n", median)
        fmt.Printf("variance= %v\n", variance)
        fmt.Printf("std-dev=  %v\n", stddev)
}
```

The program above performs some basic statistical operations on our dataset:

```sh
$> go run stats.go
... dependency download logs ...
data: [1.00794 4.002602 6.941 9.012182 10.811 12.0107 14.0067 15.9994 18.9984032 20.1797 22.98976928 24.305 26.9815386 28.0855 30.973762 32.065 35.453 39.948 39.0983 40.078 44.955912 47.867 50.9415 51.9961 54.938045 55.845 58.933195 58.6934 63.546 65.38 69.723 72.64 74.9216 78.96 79.904 83.798 85.4678 87.62 88.90585 91.224 92.90638 95.96 98 101.07 102.9055 106.42 107.8682 112.411 114.818 118.71 121.76 127.6 126.90447 131.293 132.9054519 137.327 138.90547 140.116 140.90765 144.242 145 150.36 151.964 157.25 158.92535 162.5 164.93032 167.259 168.93421 173.054 174.9668 178.49 180.94788 183.84 186.207 190.23 192.217 195.084 196.966569 200.59 204.3833 207.2 208.9804 209 210 222 223 226 227 232.03806 231.03588 238.02891 237 244 243 247 247 251 252 257 258 259 262 267 268 271 272 270 276 281 280 285 284 289 288 293 294 294]
data: [1.00794 4.002602 6.941 9.012182 10.811 12.0107 14.0067 15.9994 18.9984032 20.1797 22.98976928 24.305 26.9815386 28.0855 30.973762 32.065 35.453 39.0983 39.948 40.078 44.955912 47.867 50.9415 51.9961 54.938045 55.845 58.6934 58.933195 63.546 65.38 69.723 72.64 74.9216 78.96 79.904 83.798 85.4678 87.62 88.90585 91.224 92.90638 95.96 98 101.07 102.9055 106.42 107.8682 112.411 114.818 118.71 121.76 126.90447 127.6 131.293 132.9054519 137.327 138.90547 140.116 140.90765 144.242 145 150.36 151.964 157.25 158.92535 162.5 164.93032 167.259 168.93421 173.054 174.9668 178.49 180.94788 183.84 186.207 190.23 192.217 195.084 196.966569 200.59 204.3833 207.2 208.9804 209 210 222 223 226 227 231.03588 232.03806 237 238.02891 243 244 247 247 251 252 257 258 259 262 267 268 270 271 272 276 280 281 284 285 288 289 293 294 294] (sorted)
mean=     146.43746355915252
median=   140.90765
variance= 8026.634755570227
std-dev=  89.59148818704948
```

Thanks for reading!

We welcome your feedback and questions via our [Frictionless Data Gitter chat](http://gitter.im/frictionlessdata/chat) or via [GitHub issues](https://github.com/frictionlessdata/datapackage-go/issues) on the datapackage-go repository.
