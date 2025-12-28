# Практикум 1: ООП демонстрація
# Предметна область: Кіберспортивна ліга

from abc import ABC, abstractmethod
from typing import List


class Player:
    def __init__(self, nickname: str, age: int, country: str):
        self.nickname = nickname
        self.age = age
        self.country = country

    def get_info(self) -> str:
        return f"{self.nickname}, {self.age} р., {self.country}"


class Competitor(ABC):
    def __init__(self, name: str, rating: int):
        self.name = name
        self._rating = rating

    @abstractmethod
    def get_desc(self) -> str:
        pass

    def get_rating(self) -> int:
        return self._rating

    def set_rating(self, val: int) -> None:
        if self._check_rating(val):
            self._rating = val

    def _check_rating(self, val: int) -> bool:
        return 0 <= val <= 10000

    def get_summary(self) -> str:
        return f"{self.name} (рейтинг: {self._rating})"


class Team(Competitor):
    def __init__(self, name: str, rating: int, captain: Player, roster: List[Player]):
        super().__init__(name, rating)
        self.captain = captain
        self.roster = roster

    def get_desc(self) -> str:
        return f"Команда '{self.name}', {len(self.roster)} гравців"

    def get_summary(self) -> str:
        base = super().get_summary()
        return f"{base}, капітан: {self.captain.nickname}"


class SoloPlayer(Competitor):
    def __init__(self, name: str, rating: int, player: Player, game: str):
        super().__init__(name, rating)
        self.player = player
        self.game = game

    def get_desc(self) -> str:
        return f"Сольний гравець '{self.name}', гра: {self.game}"

    def get_summary(self) -> str:
        base = super().get_summary()
        return f"{base}, {self.player.country}"


class Match:
    def __init__(self, match_id: int, comp_a: Competitor, comp_b: Competitor):
        self.match_id = match_id
        self.comp_a = comp_a
        self.comp_b = comp_b
        self._score: List[int] = [0, 0]

    def set_score(self, a: int, b: int) -> None:
        self._score = [a, b]

    def get_score(self) -> List[int]:
        return self._score.copy()

    def get_winner(self) -> str:
        if self._score[0] > self._score[1]:
            return self.comp_a.name
        elif self._score[1] > self._score[0]:
            return self.comp_b.name
        return "Нічия"

    def get_desc(self) -> str:
        return f"Матч #{self.match_id}: {self.comp_a.name} vs {self.comp_b.name}"


class Tournament:
    def __init__(self, title: str, prize_pool: int):
        self.title = title
        self.prize_pool = prize_pool
        self._matches: List[Match] = []
        self.sponsors: List[str] = []

    def add_match(self, m: Match) -> None:
        self._matches.append(m)

    def get_matches(self) -> List[Match]:
        return self._matches.copy()

    def match_count(self) -> int:
        return len(self._matches)

    def add_sponsor(self, s: str) -> None:
        self.sponsors.append(s)


if __name__ == "__main__":
    # NAVI roster
    p1 = Player("s1mple", 26, "Україна")
    p2 = Player("b1t", 21, "Україна")
    p3 = Player("jL", 24, "Литва")
    p4 = Player("iM", 20, "Казахстан")
    p5 = Player("w0nderful", 18, "Україна")

    # G2 roster
    p6 = Player("NiKo", 27, "Боснія")
    p7 = Player("huNter", 29, "Боснія")
    p8 = Player("nexa", 28, "Сербія")
    p9 = Player("HooXi", 28, "Данія")
    p10 = Player("ZywOo", 23, "Франція")

    print("[Players]")
    for p in [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]:
        print(f"  {p.get_info()}")

    navi = Team("Natus Vincere", 2850, p1, [p1, p2, p3, p4, p5])
    g2 = Team("G2 Esports", 2720, p6, [p6, p7, p8, p9, p10])

    print("\n[Teams]")
    print(f"  {navi.get_desc()} | {navi.get_summary()}")
    print(f"  {g2.get_desc()} | {g2.get_summary()}")

    # Rating methods demo
    print(f"  NAVI rating: {navi.get_rating()}")
    navi.set_rating(2900)
    print(f"  NAVI new rating: {navi.get_rating()}")

    # Solo players (not in teams)
    p11 = Player("Twistzz", 24, "Канада")
    p12 = Player("ropz", 24, "Естонія")

    solo1 = SoloPlayer("Twistzz", 2750, p11, "CS2")
    solo2 = SoloPlayer("ropz", 2800, p12, "CS2")

    print("\n[Solo]")
    print(f"  {solo1.get_desc()} | {solo1.get_summary()}")
    print(f"  {solo2.get_desc()} | {solo2.get_summary()}")

    m1 = Match(1, navi, g2)
    m1.set_score(16, 12)
    m2 = Match(2, solo1, solo2)
    m2.set_score(13, 16)

    print("\n[Matches]")
    for m in [m1, m2]:
        print(f"  {m.get_desc()} -> {m.get_score()} ({m.get_winner()})")

    major = Tournament("IEM Katowice 2024", 1_000_000)
    major.add_match(m1)
    major.add_match(m2)
    major.add_sponsor("Intel")
    major.add_sponsor("Logitech")

    print("\n[Tournament]")
    print(f"  {major.title} | ${major.prize_pool:,} | {major.match_count()} matches")
    print(f"  sponsors: {', '.join(major.sponsors)}")
    print(f"  matches: {[m.get_desc() for m in major.get_matches()]}")

    print("\n[Polymorphism]")
    all_comp: List[Competitor] = [navi, g2, solo1, solo2]
    for c in all_comp:
        print(f"  {c.get_desc()}")
