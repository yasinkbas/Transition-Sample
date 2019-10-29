//
//  Planet.swift
//  Transition-Sample
//
//  Created by Yasin Akbaş on 28.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

let planets = Planet.all()

class Planet {
    let name: String
    let image: UIImage?
    let desc: String?
    let scale: CGFloat
    
    internal init(name: String, image: String, desc: String?, scale: CGFloat = 1) {
        self.name = name
        self.image = UIImage(named: image)
        self.desc = desc
        self.scale = scale
    }
    
    static func all() -> [Planet] {
        return [
            Planet(
                name: "Mercury",
                image: "mercury",
                desc:
                """
                This small planet spins around slowly compared to Earth, so one day lasts a long time. Mercury takes 59 Earth days to make one full rotation. A year on Mercury goes by fast. Because it’s the closest planet to the sun, it doesn’t take very long to go all the way around. It completes one revolution around the sun in just 88 Earth days. If you lived on Mercury, you’d have a birthday every three months!

                A day on Mercury is not like a day here on Earth. For us, the sun rises and sets each and every day. Because Mercury has a slow spin and short year, it takes a long time for the sun to rise and set there. Mercury only has one sunrise every 180 Earth days! Isn't that weird?
                """,
                scale: 0.2
            ),
            
            Planet(
                name: "Venus",
                image: "venus",
                desc: """
                Venus looks like a very active planet. It has mountains and volcanoes. Venus is similar in size to Earth. Earth is just a little bit bigger.

                Venus is unusual because it spins the opposite direction of Earth and most other planets. And its rotation is very slow. It takes about 243 Earth days to spin around just once. Because it's so close to the sun, a year goes by fast. It takes 225 Earth days for Venus to go all the way around the sun. That means that a day on Venus is a little longer than a year on Venus.
                """,
                scale: 0.3
            ),
            
            Planet(
                name: "Earth",
                image: "earth",
                desc: """
                Our home planet Earth is a rocky, terrestrial planet. It has a solid and active surface with mountains, valleys, canyons, plains and so much more. Earth is special because it is an ocean planet. Water covers 70% of Earth's surface.

                Our atmosphere is made mostly of nitrogen and has plenty of oxygen for us to breathe. The atmosphere also protects us from incoming meteoroids, most of which break up in our atmosphere before they can strike the surface as meteorites.

                Since we live here, you might think we know all there is to know about Earth. Not at all, actually! We have a lot we can learn about our home planet. Right now, there are many satellites orbiting Earth taking pictures and measurements. This is how we can learn more about weather, oceans, soil, climate change, and many other important topics.
                """,
                scale: 0.45
            ),
            
            Planet(
                name: "Mars",
                image: "mars",
                desc: """
                Like Earth, Mars has seasons, polar ice caps, volcanoes, canyons, and weather. It has a very thin atmosphere made of carbon dioxide, nitrogen, and argon.

                There are signs of ancient floods on Mars, but now water mostly exists in icy dirt and thin clouds. On some Martian hillsides, there is evidence of liquid salty water in the ground.

                Scientists want to know if Mars may have had living things in the past. They also want to know if Mars could support life now or in the future.
                """,
                scale: 0.35
            ),
            
            Planet(
                name: "Jupiter",
                image: "jupiter",
                desc: """
                Jupiter is the biggest planet in our solar system. It's similar to a star, but it never got big enough to start burning. It is covered in swirling cloud stripes. It has big storms like the Great Red Spot, which has been going for hundreds of years. Jupiter is a gas giant and doesn't have a solid surface, but it may have a solid inner core about the size of Earth. Jupiter also has rings, but they're too faint to see very well.
                """,
                scale: 1
            ),
            
            Planet(
                name: "Saturn",
                image: "saturn",
                desc: """
                Saturn isn’t the only planet to have rings, but it definitely has the most beautiful ones. The rings we see are made of groups of tiny ringlets that surround Saturn. They’re made of chunks of ice and rock. Like Jupiter, Saturn is mostly a ball of hydrogen and helium

                When Galileo Galilei saw Saturn through a telescope in the 1600s, he wasn't sure what he was seeing. At first he thought he was looking at three planets, or a planet with handles. Now we know those "handles" turned out to be the rings of Saturn.
                """,
                scale: 1
            ),
            
            Planet(
                name: "Uranus",
                image: "uranus",
                desc: """
                Uranus is made of water, methane, and ammonia fluids above a small rocky center. Its atmosphere is made of hydrogen and helium like Jupiter and Saturn, but it also has methane. The methane makes Uranus blue.

                Uranus also has faint rings. The inner rings are narrow and dark. The outer rings are brightly colored and easier to see. Like Venus, Uranus rotates in the opposite direction as most other planets. And unlike any other planet, Uranus rotates on its side.
                """,
                scale: 0.6
            ),
            
            Planet(
                name: "Neptune",
                image: "neptune",
                desc: """
                Neptune is dark, cold, and very windy. It's the last of the planets in our solar system. It's more than 30 times as far from the sun as Earth is. Neptune is very similar to Uranus. It's made of a thick fog of water, ammonia, and methane over an Earth-sized solid center. Its atmosphere is made of hydrogen, helium, and methane. The methane gives Neptune the same blue color as Uranus. Neptune has six rings, but they're very hard to see.
                """,
                scale: 0.5
            ),
            
            Planet(
                name: "Pluto",
                image: "pluto",
                desc: """
                Pluto, once considered the ninth and most distant planet from the sun, is now the largest known dwarf planet in the solar system. It is also one of the largest known members of the Kuiper Belt, a shadowy zone beyond the orbit of Neptune thought to be populated by hundreds of thousands of rocky, icy bodies each larger than 62 miles (100 kilometers) across, along with 1 trillion or more comets.
                """,
                scale: 0.1
            )
        ]
    }
}
