struct MoviePresentable {
    let title: String
    let description: String

    let releaseYear: Int
}

extension MoviePresentable: Equatable {}

func == (lhs: MoviePresentable, rhs: MoviePresentable) -> Bool {
    return lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.releaseYear == rhs.releaseYear
}

extension MoviePresentable {
    static var mock: [MoviePresentable] {
        return [
            MoviePresentable(
                title: "Pulp Fiction",
                description: "The lives of two mob hit men, a boxer, a gangster's wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
                releaseYear: 1994),
            MoviePresentable(
                title: "Wildwood Days",
                description: "WILDWOOD DAYS is the pop culture history of a quirky rock 'n roll resort of neon-lit motels being threatened by a wrecking ball - as told by Bruce Willis, Dick Clark, Chubby Checker, Bobby ...",
                releaseYear: 2008),
            MoviePresentable(
                title: "Die Hard",
                description: "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.",
                releaseYear: 1988),
            MoviePresentable(
                title: "The Sixth Sense",
                description: "A boy who communicates with spirits that don't know they're dead seeks the help of a disheartened child psychologist.",
                releaseYear: 1999),
            MoviePresentable(
                title: "Sin City",
                description: "A film that explores the dark and miserable town, Basin City, and tells the story of three different people, all caught up in violent corruption.",
                releaseYear: 2005),
            MoviePresentable(
                title: "Twelve Monkeys",
                description: "In a future world devastated by disease, a convict is sent back in time to gather information about the man-made virus that wiped out most of the human population on the planet.",
                releaseYear: 1995),
            MoviePresentable(
                title: "Moonrise Kingdom",
                description: "A pair of young lovers flee their New England town, which causes a local search party to fan out to find them.",
                releaseYear: 2012),
            MoviePresentable(
                title: "Lucky Number Slevin",
                description: "A case of mistaken identity lands Slevin into the middle of a war being plotted by two of the city's most rival crime bosses: The Rabbi and The Boss. Slevin is under constant surveillance by relentless Detective Brikowski as well as the infamous assassin Goodkat and finds himself having to hatch his own ingenious plot to get them before they get him.",
                releaseYear: 2006)
        ]
    }
}
